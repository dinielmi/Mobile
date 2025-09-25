import 'dart:io';


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
