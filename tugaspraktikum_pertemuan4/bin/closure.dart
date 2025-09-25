import 'dart:io';

//4. Closure untuk diskon bertingkat

Function buatDiskonBertingkat() {
  var diskon = 0;

  return (int harga) {
    diskon += 5;
    diskon = diskon > 50 ? 50 : diskon; // batasi max 50% tanpa if/else panjang
    var potongan = harga * diskon / 100;
    return "Diskon $diskon% → Total Bayar: Rp${harga - potongan}";
  };
}

void main() {
  var hitungDiskon = buatDiskonBertingkat();

  print(hitungDiskon(100000)); // 5%
  print(hitungDiskon(100000)); // 10%
  print(hitungDiskon(100000)); // 15%
  print(hitungDiskon(100000)); // 20%

}
