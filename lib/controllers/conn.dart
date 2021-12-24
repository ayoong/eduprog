import 'package:get/get.dart';


/// pengaturan controller untuk koneksi ke database
class Conn extends GetConnect{

    // alamat ip khusus untuk emulator, jika tidak menggunakan emulator maka gunakan  ip pc
    // contoh http://192.168.***** dan seterusnya
    // penggunaan [undescore] atau garis bawah pada _url , menandakan private 
    // agar property tidak bisa diakses dari luar class
  //  final _url = "http://10.0.2.2:3000";
   final _url = "http://127.0.0.1:3000";

  // Map<String, dinami> adalah alias dari <String, dynamic>{}, atau {}, untuk menandakan dynamic, dynamic dan penyebutannya adalah map
  // dynamic adalah variable multy dan bebas , bisa berubah menjadi apapun contoh menjadi string , int, ataupun map
   Future<Response> login(Map<String, dynamic> body) => post(_url+'/login', body);

   Future<Response> transaksi(String tanggal) => get(_url+"/transaksi/$tanggal");

   Future<Response> chart() => get(_url+"/chart");
   Future<Response> ritAndTonase() => get(_url+"/ritAndTonase");
}