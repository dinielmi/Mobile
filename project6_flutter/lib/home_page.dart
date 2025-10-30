import 'package:flutter/material.dart';
import 'package:project6_flutter/galeri_page.dart';
import 'package:project6_flutter/profil_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE6CA), // Cream background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // =====================
              // HEADER (tanpa rounded)
              // =====================
              Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFFF45531), // Orange terang
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.school, size: 70, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to Project 6 Flutter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // =====================
              // TEKS UTAMA
              // =====================
              const Text(
                'Choose a Page',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2B28), // coklat tua
                ),
              ),

              const SizedBox(height: 25),

              // =====================
              // MENU CARD
              // =====================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _menuCard(
                    context,
                    Icons.person,
                    'Profile',
                    const Color(0xFFF45531), // Orange terang
                    ProfilPage(),
                  ),
                  const SizedBox(width: 20),
                  _menuCard(
                    context,
                    Icons.photo_album,
                    'Gallery',
                    const Color(0xFFF45531), // Orange terang
                    GaleriPage(),
                  ),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard(
      BuildContext context, IconData icon, String title, Color color, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        color: color,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 55),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
