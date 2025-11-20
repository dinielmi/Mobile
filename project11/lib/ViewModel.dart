import 'package:flutter/material.dart';
import 'package:project11/Model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppSettings settings = AppSettings();

  void toggleTheme() {
    setState(() {
      settings.isDarkMode = !settings.isDarkMode;
    });
  }

  void updateName(String newName) {
    setState(() {
      settings.username = newName;
    });
  }

  void decreaseFont() {
    setState(() {
      if (settings.fontSize > 8) {
        settings.fontSize -= 2;
      }
    });
  }

  void increaseFont() {
    setState(() {
      settings.fontSize += 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Mengatur tema aplikasi secara global
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: settings.backgroundColor,
        appBar: AppBar(
          title: Text('Aplikasi Settings Sederhana', style: TextStyle(color: Colors.white)),
          backgroundColor: settings.isDarkMode ? Colors.grey[900] : Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView( // Menggunakan ListView agar dapat digulir jika layar kecil
            children: [
              // --- Bagian Sambutan dengan Ukuran Font Dinamis ---
              Text(
                settings.greeting,
                style: TextStyle(
                  fontSize: settings.fontSize.toDouble(),
                  color: settings.textColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // --- Kontrol Mode Gelap/Terang ---
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode ? Colors.grey[800] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mode : ${settings.isDarkMode ? 'Gelap' : 'Terang'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: settings.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      value: settings.isDarkMode,
                      onChanged: (value) => toggleTheme(),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // --- INPUT NAMA ---
              TextField(
                onChanged: updateName,
                decoration: InputDecoration(
                  labelText: 'Ubah Nama',
                  labelStyle: TextStyle(color: settings.textColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: settings.isDarkMode ? Colors.grey[800] : Colors.grey[100],
                ),
                style: TextStyle(color: settings.textColor),
              ),

              SizedBox(height: 20),

              // --- UKURAN FONT ---
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ukuran Font: ${settings.fontSize}',
                      style: TextStyle(
                        color: settings.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: decreaseFont,
                          icon: Icon(Icons.remove_circle, color: settings.textColor),
                          tooltip: 'Perkecil Font',
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: increaseFont,
                          icon: Icon(Icons.add_circle, color: settings.textColor),
                          tooltip: 'Perbesar Font',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // --- PREVIEW TEXT ---
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: settings.textColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Ini adalah preview text dengan ukuran font ${settings.fontSize}',
                  style: TextStyle(
                    fontSize: settings.fontSize.toDouble(),
                    color: settings.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // --- Floating Action Button ---
        floatingActionButton: FloatingActionButton(
          onPressed: toggleTheme,
          child: Icon(settings.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
          backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
          tooltip: 'Ganti Tema',
        ),
      ),
    );
  }
}
        