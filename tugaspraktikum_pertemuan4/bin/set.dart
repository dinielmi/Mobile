import 'dart:io';

//2. Menghitung Union & Intersection dari dua set string

void main() {
  print("Masukkan elemen set A (pisahkan dengan spasi):");
  Set<String> setA = stdin.readLineSync()!.split(" ").toSet();

  print("Masukkan elemen set B (pisahkan dengan spasi):");
  Set<String> setB = stdin.readLineSync()!.split(" ").toSet();

  // Union
  Set<String> unionSet = setA.union(setB);

  // Intersection
  Set<String> intersectionSet = setA.intersection(setB);

  print("Set A: $setA");
  print("Set B: $setB");
  print("Union: $unionSet");
  print("Intersection: $intersectionSet");
}
