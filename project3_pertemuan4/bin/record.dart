import 'dart:io'; 

void main(){
  var mahasiswa = ("Diniel", 20, true);
  print(mahasiswa);
  print(mahasiswa.$1);
  print(mahasiswa.$2);

  //named record
  var mhs = (nama: "Diniel", umur : 20);
  print("Nama : ${mhs.nama}, Umur : ${mhs.umur}");

}