import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_page.dart'; // ← tambahkan ini

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data contoh: foto + tanggal + deskripsi
    final List<Map<String, dynamic>> photos = [
      {
        'url': 'https://picsum.photos/id/10/600/800',
        'date': DateTime(2025, 10, 17),
        'desc': 'Foto pemandangan indah di sore hari.'
      },
      {
        'url': 'https://picsum.photos/id/20/600/800',
        'date': DateTime(2025, 10, 17),
        'desc': 'Foto bunga mekar di taman kota.'
      },
      {
        'url': 'https://picsum.photos/id/30/600/800',
        'date': DateTime(2025, 10, 16),
        'desc': 'Langit senja dengan warna oranye keemasan.'
      },
      {
        'url': 'https://picsum.photos/id/40/600/800',
        'date': DateTime(2025, 10, 15),
        'desc': 'Suasana pagi di tepi danau.'
      },
      {
        'url': 'https://picsum.photos/id/50/600/800',
        'date': DateTime(2025, 10, 15),
        'desc': 'Jalan setapak di tengah pepohonan hijau.'
      },
    ];

    // Kelompokkan foto berdasarkan tanggal
    final Map<String, List<Map<String, dynamic>>> groupedPhotos = {};
    for (var photo in photos) {
      String formattedDate =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(photo['date']);
      groupedPhotos.putIfAbsent(formattedDate, () => []).add(photo);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: groupedPhotos.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header tanggal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              // Grid foto di bawah tanggal
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: entry.value.length,
                itemBuilder: (context, index) {
                  final photo = entry.value[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhotoDetailPage(
                            imageUrl: photo['url'],
                            date: entry.key,
                            desc: photo['desc'],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: photo['url'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          photo['url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

