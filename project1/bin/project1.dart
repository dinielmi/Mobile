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
  num nilai = 90.5;
  stdout.writeln("Nilai saya $nilai");
  dynamic bebas = 16;
  stdout.writeln("Nilai dari dynamic adalah $bebas");

  // String angka1 = "15";
  // int angka2 = int.parse(angka1);
  // int angka3 = bebas;

  // list
  List <String> hobby = ['Membaca', 'Menulis', 'Menononton'];
  hobby.add("Main Game");
  stdout.writeln("Hobby saya: $hobby");

  Map<String, String> data = {
    'nama': 'Dini Elminigtyas',
    'alamat': 'Batu',
    'pekerjaan': 'Mahasiswa'
  };

  data.addAll({'hobby': 'Membaca'});
  stdout.writeln("Data saya: $data");
  stdout.writeln("Nama yang ada di data ${data['nama']}");

try {
  // Code that might throw an exception
  int result = 10 ~/ 0; // This will throw an IntegerDivisionByZeroException

  // Handles the specific IntegerDivisionByZeroException
  print("Cannot divide by zero!");
} on IntegerDivisionByZeroException {
  print("Cannot divide by zero!");
} catch (e) {
  // Handles any other type of exception and provides the exception object
  print("An unexpected error occurred: $e");
} finally {
  // Code that always executes, regardless of whether an exception occurred
  print("Execution complete.");
}

String? kendaraan;
String kendaraan1 = "bajai";
stdout.writeln("kendaraan $kendaraan");


}
