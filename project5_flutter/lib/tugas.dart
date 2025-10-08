import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Profile & Project Counter",
      home: DeeApp(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFCDC1),
      ),
    ),
  );
}

//DeeApp Menggunakan Statefulwidget
class DeeApp extends StatefulWidget {
  @override
  State<DeeApp> createState() => _DeeAppState();
}

//DeeAppp meliputi counter page n appbar
class _DeeAppState extends State<DeeApp> {
  int _selectedIndex = 0;
  int _counter = 0;
  List<String> _projectList = [];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  // Popup tambah proyek
  void _addProject() {
    String newProject = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF536878),
          title: const Text(
            "Add New Project",
            style: TextStyle(color: Color(0xFFFFCDC1)),
          ),
          content: TextField(
            style: const TextStyle(color: Color(0xFFFFCDC1)),
            cursorColor: Color(0xFFFFCDC1),
            decoration: const InputDecoration(
              hintText: "Project Name",
              hintStyle: TextStyle(color: Color(0xFFFFCDC1)),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFCDC1)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFCDC1)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFCDC1)),
              ),
            ),
            onChanged: (value) => newProject = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Cancel", style: TextStyle(color: Color(0xFFFFCDC1))),
            ),
            TextButton(
              onPressed: () {
                if (newProject.isNotEmpty) {
                  setState(() {
                    _counter++;
                    _projectList.add(newProject);
                  });
                }
                Navigator.pop(context);
              },
              child:
                  const Text("Save", style: TextStyle(color: Color(0xFFFFCDC1))),
            ),
          ],
        );
      },
    );
  }

  // Popup hapus proyek
  void _removeProject() {
    if (_projectList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Belum ada proyek untuk dihapus")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF536878),
          title: const Text(
            "Hapus Proyek",
            style: TextStyle(color: Color(0xFFFFCDC1)),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _projectList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _projectList[index],
                    style: const TextStyle(color: Color(0xFFFFCDC1)),
                  ),
                  trailing: const Icon(Icons.delete, color: Color(0xFFFFCDC1)),
                  onTap: () {
                    setState(() {
                      _counter--;
                      _projectList.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xFFFFCDC1)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? "My Profile" : "Project Counter",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFCDC1),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFFFCDC1)),
        backgroundColor: const Color(0xFF536878),
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          child: Container(
            color: const Color(0xFFFFCDC1),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: const Color(0xFF536878),
                  height: 110,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Color(0xFFFFCDC1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profil'),
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_chart),
                  title: const Text('Counter'),
                  onTap: () {
                    Navigator.pop(context);
                    _onItemTapped(1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body: _selectedIndex == 0
          ? MyProfilePage(counter: _counter, projectList: _projectList)
          : _buildProjectCounter(),

      floatingActionButton: _selectedIndex == 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "btnMinus",
                  backgroundColor: const Color(0xFF536878),
                  foregroundColor: const Color(0xFFFFCDC1),
                  onPressed: _removeProject,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: "btnAdd",
                  backgroundColor: const Color(0xFF536878),
                  foregroundColor: const Color(0xFFFFCDC1),
                  onPressed: _addProject,
                  child: const Icon(Icons.add),
                ),
              ],
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF536878),
        selectedItemColor: const Color(0xFFFFCDC1),
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Counter'),
        ],
      ),
    );
  }

  Widget _buildProjectCounter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Tambah Project",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF536878),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$_counter",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF536878),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Tekan tombol + untuk menambah project",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _counter = 0;
                _projectList.clear();
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF536878),
              side: const BorderSide(color: Color(0xFF536878)),
            ),
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}

//Halaman Profile menggunakan Stateless Widget
class MyProfilePage extends StatelessWidget {
  final int counter;
  final List<String> projectList;

  const MyProfilePage({
    super.key,
    required this.counter,
    required this.projectList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Flutter logo positioned top-left inside the header area
                const Positioned(
                  right: 0,
                  top: 0,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: FlutterLogo(size: 32),
                  ),
                ),
                // School icon stays centered
                const Icon(Icons.school, size: 80, color: Color(0xFF536878)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/image/profile.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/image/profile.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Placeholder(
                        fallbackWidth: 120,
                        fallbackHeight: 120,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      "Nama : Dee Elminingtyas",
                      style: GoogleFonts.averiaLibre(
                        fontSize: 16,
                        color: const Color(0xFF536878),
                      ),
                    ),
                    Text(
                      "NIM : 2341760180",
                      style: GoogleFonts.averiaLibre(
                        fontSize: 16,
                        color: const Color(0xFF536878),
                      ),
                    ),
                    Text(
                      "Jurusan : Teknologi Informasi",
                      style: GoogleFonts.averiaLibre(
                        fontSize: 16,
                        color: const Color(0xFF536878),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Divider(color: Color(0xFF536878), thickness: 1),
          const SizedBox(height: 10),
          Text(
            "Project: $counter",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF536878),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFF536878), thickness: 1),
          const Text(
            "Project List:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF536878),
            ),
          ),
          Expanded(
            child: projectList.isEmpty
                ? const Text("Belum ada proyek ditambahkan.",
                    style: TextStyle(color: Colors.black54))
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 8),
                    itemCount: projectList.length,
                    itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.circle,
                                  color: Color(0xFF536878), size: 10),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  projectList[index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
