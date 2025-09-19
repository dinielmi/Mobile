import 'dart:io';

import 'package:project3_pertemuan4/project3_pertemuan4.dart' as project3_pertemuan4;


void main(List<String> arguments) {

// var sudah = {'nim': '101', 'nama': 'Dee', 'umur': 20, 'nim': '102'};
// print(sudah);
// print(sudah['nama']);

var list = {
  'nim' : ["505", "404"],
  'nama' : ["Dee", "Elminingtyas"],
  'umur' : [20, 21],
};
print(list);
print(list['nama']);
print(list['nama']![1]);

}
