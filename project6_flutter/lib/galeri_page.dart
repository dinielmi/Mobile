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
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text('Galeri Mahasiswa'),  backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: imagePaths.map((path) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(path, fit: BoxFit.cover),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}