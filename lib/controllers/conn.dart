import 'package:get/get.dart';


/// pengaturan controller untuk koneksi ke database
class Conn extends GetConnect{

    // alamat ip khusus untuk emulator, jika tidak menggunakan emulator maka gunakan  ip pc
    // contoh http://192.168.***** dan seterusnya
    // penggunaan [undescore] atau garis bawah pada _url , menandakan private 
    // agar property tidak bisa diakses dari luar class
   final _url = "http://10.0.2.2:3000";
  //  final _url = "http://127.0.0.1:3000";

  // Map<String, dinami> adalah alias dari <String, dynamic>{}, atau {}, untuk menandakan dynamic, dynamic dan penyebutannya adalah map
  // dynamic adalah variable multy dan bebas , bisa berubah menjadi apapun contoh menjadi string , int, ataupun map
   Future<Response> login(Map<String, dynamic> body) => post(_url+'/login', body);

   Future<Response> transaksi(String tanggal) => get(_url+"/transaksi/$tanggal");

   Future<Response> chart(String tanggal) => get(_url+"/chart/"+tanggal);
   Future<Response> ritAndTonase(String tanggal) => get(_url+"/ritAndTonase/"+tanggal);

   Future<Response> ritTonasePerBulan(String tanggal) => get(_url+"/ritTonasePerBulan/"+tanggal);
   Future<Response> transaksiPerBulan(String tanggal) => get(_url+"/transaksiPerBulan/"+tanggal);
   Future<Response> jamTerakhir() => get(_url+"/jamTerakhir");
}