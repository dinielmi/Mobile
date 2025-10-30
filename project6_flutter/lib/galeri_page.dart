import 'package:flutter/material.dart';

class GaleriPage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/image/hiro neo.jpeg',
    'assets/image/hiro red.jpeg',
    'assets/image/hiro stah.jpeg',
    'assets/image/hiro bear.jpeg',
    'assets/image/hiro orange.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE6CA), // cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF45531), // orange terang
        title: const Text(
          'Galeri Mahasiswa',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: imagePaths.map((path) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEDE6CA), // cream lembut di atas
                    Color(0xFF443842), // ungu gelap ke bawah
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Gambar utama
                    Image.asset(path, fit: BoxFit.cover),

                    // Overlay gradasi halus di atas gambar
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.25),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    // Ikon favorit di pojok kanan atas
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFFF45531), // orange
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
