import 'dart:io';

void main() {
  // Map untuk menyimpan data mahasiswa
  Map<String, int> mahasiswa = {};

  // Input data untuk 5 mahasiswa
  for (int i = 1; i <= 5; i++) {
    stdout.write('Masukkan nama mahasiswa ke-$i: ');
    String? nama = stdin.readLineSync();
    stdout.write('Masukkan nilai $nama: ');
    int? nilai = int.tryParse(stdin.readLineSync() ?? '0');

    if (nama != null && nilai != null) {
      mahasiswa[nama] = nilai;
    } else {
      print('Input tidak valid. Coba lagi.');
      i--; // ulangi input jika tidak valid
    }
  }

  // Menentukan kategori nilai
  Map<String, String> kategori = {};
  mahasiswa.forEach((nama, nilai) {
    String grade;
    if (nilai >= 80) {
      grade = 'A';
    } else if (nilai >= 60) {
      grade = 'B';
    } else {
      grade = 'C';
    }
    kategori[nama] = grade;
  });

  // Tampilkan hasil akhir
  print('\nDaftar Mahasiswa dan Kategorinya(Grade):');
  print('+----------------------+-------+');
  print('| Nama Mahasiswa       | Grade |');
  print('+----------------------+-------+');
  kategori.forEach((nama, grade) {
    // format nama 20 karakter, grade 5 karakter
    print('| ${nama.padRight(20)} | ${grade.padRight(5)} |');
  });
  print('+----------------------+-------+');
}
