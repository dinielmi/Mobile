import 'dart:io';

import 'package:project1/project1.dart' as project1;
const String nama = 'Dini';

void main(List<String> arguments) {
  // print('Hello world: ${project1.calculate()}!');
  // satu line comment
  /*
  multi line comment
  banyak line comment
  */
  // constanta dan final
  final String nama2 = 'Elminigtyas';
  print("Nama saya $nama $nama2");
  //  variabel
  int umur = 20;
  double tinggi = 151.5;
  bool jenis_kelamin = false; //true = perempuan, false = laki-laki
  String alamat = 'Jl. Melati No. 20';
  stdout.writeln("Umur saya $umur tahun");
  stdout.writeln("Tinggi saya $tinggi cm");
  // stdout.writeln("Saya ${jenis_kelamin ? 'Perempuan' : 'Laki-laki'}");
  if (jenis_kelamin==true) {
    stdout.writeln("Saya Perempuan");
  } else {
    stdout.writeln("Saya Laki-laki"); 
  }
  stdout.writeln("Alamat saya $alamat");
}
