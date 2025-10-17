import 'package:flutter/material.dart';
import 'package:project6_flutter/galeri_page.dart';
import 'package:project6_flutter/profil_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
      title: Text('Home Page'),
      backgroundColor: Colors.blueAccent,
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(height: 16),
        const Icon(Icons.school, size: 48, color: Colors.blue),
        SizedBox(height: 16),
        Text(
              'Welcome to the App',
              style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton.icon(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilPage()),
            );
            },
            icon: Icon(Icons.person),
            label: Text('Profile'),
            style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GaleriPage()),
            );
            },
            icon: Icon(Icons.photo),
            label: Text('Gallery'),
            style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            ),
          ),
          ],
        ),
        ],
      ),
      ),
    );
  }
}
    