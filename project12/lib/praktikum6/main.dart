import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// SERVICE: FileService - util dasar untuk file handling
class FileService {
  Future<Directory> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> writeFile(String filename, String content) async {
    final Directory dir = await documentsDirectory;
    final File file = File(path.join(dir.path, filename));
    return file.writeAsString(content);
  }

  Future<String> readFile(String filename) async {
    try {
      final Directory dir = await documentsDirectory;
      final File file = File(path.join(dir.path, filename));
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  Future<bool> fileExists(String filename) async {
    final Directory dir = await documentsDirectory;
    final File file = File(path.join(dir.path, filename));
    return file.exists();
  }

  Future<void> deleteFile(String filename) async {
    final Directory dir = await documentsDirectory;
    final File file = File(path.join(dir.path, filename));
    if (await file.exists()) {
      await file.delete();
    }
  }
}

/// SERVICE: DirectoryService - util directory management
class DirectoryService {
  final FileService _fileService = FileService();

  Future<Directory> createDirectory(String dirName) async {
    final Directory appDir = await _fileService.documentsDirectory;
    final Directory newDir = Directory(path.join(appDir.path, dirName));
    if (!await newDir.exists()) {
      await newDir.create(recursive: true);
    }
    return newDir;
  }

  Future<List<FileSystemEntity>> listFiles(String dirName) async {
    final Directory dir = await createDirectory(dirName);
    return dir.list().toList();
  }

  Future<void> deleteDirectory(String dirName) async {
    final Directory appDir = await _fileService.documentsDirectory;
    final Directory dir = Directory(path.join(appDir.path, dirName));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}

/// SERVICE: NoteService - simpan setiap note di file JSON
class NoteService {
  final DirectoryService _dirService = DirectoryService();
  final String _notesDir = 'notes';

  Future<void> saveNote({
    required String title,
    required String content,
  }) async {
    final Directory notesDir = await _dirService.createDirectory(_notesDir);
    final String filename =
        '${DateTime.now().millisecondsSinceEpoch}.json'; // unix ID
    final File file = File(path.join(notesDir.path, filename));

    final noteData = {
      'title': title,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
      'file_path': file.path,
    };

    await file.writeAsString(jsonEncode(noteData));
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final Directory notesDir = await _dirService.createDirectory(_notesDir);
    final List<FileSystemEntity> files = await notesDir.list().toList();

    List<Map<String, dynamic>> notes = [];
    for (var entity in files) {
      if (entity is File && entity.path.endsWith('.json')) {
        try {
          final content = await entity.readAsString();
          final data = jsonDecode(content);
          data['file_path'] = entity.path;
          notes.add(data);
        } catch (e) {
          print('Error reading note file: $e');
        }
      }
    }

    // Urutkan dari terbaru
    notes.sort((a, b) =>
        b['created_at'].toString().compareTo(a['created_at'].toString()));

    return notes;
  }

  Future<void> deleteNoteByPath(String filePath) async {
    final File file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

/// UI: Flutter Notes App
void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes (Local File)',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService _notesService = NoteService();
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _notesService.getAllNotes();
    setState(() => _notes = notes);
  }

  Future<void> _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );
    if (result == true) {
      _loadNotes();
    }
  }

  Future<void> _deleteNote(String filePath) async {
    await _notesService.deleteNoteByPath(filePath);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Notes")),
      body: _notes.isEmpty
          ? Center(child: Text('Belum ada catatan.'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(note['title'] ?? ''),
                    subtitle: Text(
                      note['content'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteNote(note['file_path']),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(note: note),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}

/// UI: AddNotePage - form untuk menulis note baru
class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final NoteService _noteService = NoteService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Isi semua field dulu')));
      return;
    }

    await _noteService.saveNote(
      title: _titleController.text,
      content: _contentController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan disimpan')));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan Baru')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Isi Catatan'),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Simpan'),
              onPressed: _saveNote,
            ),
          ],
        ),
      ),
    );
  }
}

/// UI: NoteDetailPage - menampilkan isi note
class NoteDetailPage extends StatelessWidget {
  final Map<String, dynamic> note;
  const NoteDetailPage({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note['title'] ?? 'Note')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(note['content'] ?? ''),
      ),
    );
  }
}