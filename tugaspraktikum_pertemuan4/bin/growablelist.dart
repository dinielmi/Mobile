import 'dart:io';

//1. Menyimpan data menggunakan growable list

void main() {
  // Growable List (bisa bertambah)
  List<String> mahasiswa = [];

  // Tambah data
  mahasiswa.add("Andi");
  mahasiswa.add("Budi");
  mahasiswa.add("Citra");
  mahasiswa.add("Dewi");

  // Tampilkan data
  print("Daftar Mahasiswa: $mahasiswa");
  print("Jumlah Mahasiswa: ${mahasiswa.length}");
}
