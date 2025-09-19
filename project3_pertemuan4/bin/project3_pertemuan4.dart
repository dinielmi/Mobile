import 'dart:io';

import 'package:project3_pertemuan4/project3_pertemuan4.dart' as project3_pertemuan4;


void main(List<String> arguments) {

  // fixed List
  // print('Hello world: ${project3_pertemuan4.calculate()}!');
var fl = List<int>.filled(4,1);    
fl[0] = 1;
fl[1] = 2;
fl[2] = 3;
fl[3] = 4;
// fl[4] = 5;

//cetak
stdout.writeln(fl);

}
