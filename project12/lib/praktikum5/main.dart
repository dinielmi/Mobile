import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';  

// SERVICE: FileService - operasi dasar file handling
class FileService {
  Future<Directory> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  // Simpan data ke file (String)
  Future<File> writeFile(String filename, String content) async {
    final Directory dir = await documentsDirectory;
    final File file = File(path.join(dir.path, filename));
    return file.writeAsString(content);
  }

  // Baca data dari file
  Future<String> readFile(String filename) async {
    try {
      final Directory dir = await documentsDirectory;
      final File file = File(path.join(dir.path, filename));
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  // Simpan object sebagai JSON
  Future<File> writeJson(String filename, Map<String, dynamic> json) async {
    final String content = jsonEncode(json);
    return writeFile(filename, content);
  }

  // Baca JSON dari file
  Future<Map<String, dynamic>?> readJson(String filename) async {
    try {
      final String content = await readFile(filename);
      return jsonDecode(content);
    } catch (e) {
      return null;
    }
  }

  // Cek apakah file ada
  Future<bool> fileExists(String filename) async {
    final Directory dir = await documentsDirectory;
    final File file = File(path.join(dir.path, filename));
    return file.exists();
  }

  // Hapus file
  Future<void> deleteFile(String filename) async {
    try {
      final Directory dir = await documentsDirectory;
      final File file = File(path.join(dir.path, filename));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}

// SERVICE: UserDataService - untuk menyimpan dan membaca user data
class UserDataService {
  final FileService _fileService = FileService();
  final String _fileName = 'user_data.json';

  Future<void> saveUserData({
    required String name,
    required String email,
    int? age,
  }) async {
    final Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'age': age,
      'last_update': DateTime.now().millisecondsSinceEpoch,
    };
    await _fileService.writeJson(_fileName, userData);
  }

  Future<Map<String, dynamic>?> readUserData() async {
    final exists = await _fileService.fileExists(_fileName);
    if (!exists) return null;

    final Map<String, dynamic>? data = await _fileService.readJson(_fileName);
    return data?.isEmpty ?? true ? null : data;
  }

  Future<void> deleteUserData() async {
    await _fileService.deleteFile(_fileName);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data File Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserDataService _userService = UserDataService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Map<String, dynamic>? _savedData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Muat data user dari file JSON
  Future<void> _loadUserData() async {
    final data = await _userService.readUserData();
    setState(() {
      _savedData = data;
    });
  }

  // Simpan data ke file JSON
  Future<void> _saveUserData() async {
    await _userService.saveUserData(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      age: int.tryParse(_ageController.text),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Data berhasil disimpan')),
    );

    await _loadUserData();
  }

  // Hapus file JSON
  Future<void> _deleteUserData() async {
    await _userService.deleteUserData();
    setState(() => _savedData = null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Data user dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile User (File JSON)')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input form
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Usia',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Simpan'),
                  onPressed: _saveUserData,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _deleteUserData,
                ),
              ],
            ),
            SizedBox(height: 24),
            Divider(),

            // TAMPILAN DATA YANG DISIMPAN
            _savedData == null
                ? Text(
                    "Belum ada data tersimpan.",
                    style: TextStyle(color: Colors.grey),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📊 Data Tersimpan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildDataRow('Nama', _savedData!['name']),
                      _buildDataRow('Email', _savedData!['email']),
                      _buildDataRow('Usia', _savedData!['age'].toString()),
                      _buildDataRow(
                        'Terakhir Update',
                        _formatTimestamp(_savedData!['last_update']),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk menampilkan 1 baris data
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '-';
    try {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp as int);
      return DateFormat('dd MMM yyyy, HH:mm').format(dt);
    } catch (e) {
      return '-';
    }
  }
}