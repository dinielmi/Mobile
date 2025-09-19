import 'dart:io';

import 'package:project3_pertemuan4/project3_pertemuan4.dart' as project3_pertemuan4;


void main(List<String> arguments) {

  // print('Hello world: ${project3_pertemuan4.calculate()}!');
// fixed List
var fl = List<int>.filled(4,1);    
fl[0] = 1;
fl[1] = 2;
fl[2] = 3;
fl[3] = 4;
// fl[4] = 5;

//cetak
// stdout.writeln(fl);

// growable list
var gl = [1, 2, 3];
gl.add(4);
gl.remove(2);
stdout.writeln(gl);



}
