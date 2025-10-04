import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Profile & Project Counter",
      home: DeeApp(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFCDC1), // background semua halaman
      ),
    ),
  );
}

class DeeApp extends StatefulWidget {
  @override
  State<DeeApp> createState() => _DeeAppState();
}

class _DeeAppState extends State<DeeApp> {
  int _selectedIndex = 0;
  int _counter = 0;
  List<String> _projectList = [];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _addProject() {
    String newProject = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Project"),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Project Name",
            ),
            onChanged: (value) => newProject = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newProject.isNotEmpty) {
                  setState(() {
                    _counter++;
                    _projectList.add(newProject);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
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
          title: const Text("My Profile & Project Counter",
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
            color:Color(0xFFFFCDC1),
          ),
          ),
          backgroundColor: Color.fromARGB(255, 83, 104, 120),
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
                    color: const Color(0xFFFFCDC1),
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
      body:
          _selectedIndex == 0 ? _buildProfile() : _buildProjectCounter(),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: _addProject,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF536878), 
        selectedItemColor:  const Color(0xFFFFCDC1),
        unselectedItemColor: Colors.white70, 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Counter',
          ),
        ],
      ),
    );
  }

Widget _buildProfile() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Icon(
            Icons.school,
            size: 80,
            color: Color(0xFF536878), // Payne’s Grey
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
              ),
              const SizedBox(width: 16), // jarak antara foto dan teks
              // Kolom teks di kanan gambar
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text("Nama\t\t\t\t\t\t: Dee Elminingtyas"),
                  Text("NIM\t\t\t\t\t\t\t\t\t: 2341760180"),
                  Text("Jurusan\t\t: Sistem Informasi Bisnis"),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
        const Divider(
          color: Color(0xFF536878),
          thickness: 1,
        ),
        const SizedBox(height: 10),
        Text(
          "Project: $_counter",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF536878),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color(0xFF536878),
          thickness: 1,
        ),
        const Text(
          "Project List:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF536878),
          ),
        ),
        Expanded(
          child: _projectList.isEmpty
              ? const Text(
                  "Belum ada proyek ditambahkan.",
                  style: TextStyle(color: Colors.black54),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(left: 8),
                  itemCount: _projectList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Color(0xFF536878), // Payne’s Grey
                            size: 10,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _projectList[index],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF536878),
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


  Widget _buildProjectCounter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tambah Project"),
          const SizedBox(height: 10),
          Text("$_counter", style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 20),
          const Text("Tekan tombol + untuk menambah project"),
        ],
      ),
    );
  }
}
