import 'dart:io';


void main(List<String> arguments) {

// var setNilai1 = <int>{1, 2, 3, 4};
// var setNilai2 = <int>{3, 3, 4, 5};
// print(setNilai2); 
// print(setNilai1.union(setNilai2));
// print(setNilai1.intersection(setNilai2));

// var setNilai1 = <int>{};
// var setNilai2 = <int>{1, 2, 3};
// stdout.writeln('Jumlah data setNilai1 = ');
// String? intput1 = stdin.readLineSync();
// int jumlah1 = (int.tryParse(intput1 ?? '0')) ?? 0;
// for (var i = 0; i < jumlah1; i++) {
//   stdout.writeln('Masukkan data ke-${i + 1}: ');
//   String? inputNilai = stdin.readLineSync();
//   int nilai1 = (int.tryParse(inputNilai ?? '0')) ?? 0;
//   setNilai1.add(nilai1);
// }
// print(setNilai1);

var setNilai1 = <String>{};
var setNilai2 = <int>{1, 2, 3};
stdout.writeln('Jumlah data setNilai1 = ');
String? intput1 = stdin.readLineSync();
int jumlah1 = (int.tryParse(intput1 ?? '0')) ?? 0;
for (var i = 0; i < jumlah1; i++) {
  stdout.writeln('Masukkan data ke-${i + 1}: ');
  String? inputNilai = stdin.readLineSync();
  String nilai1 =  inputNilai ?? '0';
  setNilai1.add(nilai1);
}
// print(setNilai1);
// print(setNilai1.elementAt(0));

var NilaiList = setNilai1.toList();
print(NilaiList.elementAt(1));

}