import 'dart:io';

//3. Menggunakan Map untuk menyimpan data barang

void main() {
  Map<String, Map<String, dynamic>> barang = {
    "B001": {"nama": "Laptop", "harga": 7000000},
    "B002": {"nama": "HP", "harga": 3000000},
    "B003": {"nama": "Mouse", "harga": 150000},
  };

  print("Kode\tNama\t\tHarga");
  print("-----------------------------------");
  barang.forEach((kode, data) {
    print("$kode\t${data['nama']}\t\tRp${data['harga']}");
  });
}

