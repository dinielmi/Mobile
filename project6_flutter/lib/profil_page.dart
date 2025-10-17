import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final List<String> mataKuliah = [
    'Pemrograman Mobile',
    'Business Intelligence',
    'Audit Sistem Informasi',
    'Metodelogi Penelitian',
    'Manajemen Rantai Pasok',
    'Pengelolaaan Sumberdaya',
    'Penjaminan Mutu Perangkat Lunak',
    'Manajemen Proyek',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text('Profil Mahasiswa'),  backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto dan data diri dalam dua box terpisah
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Box foto
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                    image: DecorationImage(
                      image: AssetImage('assets/image/profile.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Box data diri
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama \t\t\t\t: Dee Elminingtyas'),
                        Text('NIM \t\t\t\t\t\t\t: 123456789'),
                        Text('Jurusan \t: Teknologi Infromasi'),
                        Text('Politeknik Negeri Malang'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Judul mata kuliah dengan garis atas dan bawah
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Center(
                child: Text(
                  'Mata Kuliah Semester 5',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 12),

            // List mata kuliah
            Expanded(
              child: ListView.builder(
                itemCount: mataKuliah.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text(mataKuliah[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}