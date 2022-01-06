import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


/// class untuk menyimpan data semenatara
/// ```dart
/// contoh : Val.user().get() // untuk mendapatkan data user yang telah disimpan
/// ```
class Val{
  final String _key;

  Val.user(): _key = "user";
  Val.perTanggal(): _key = "pertanggal";
  Val.perBulan(): _key = "perbulan";

  // untuk mendapatkan data
  get() => GetStorage().read(_key);

  // untuk menyimpan data
  set(dynamic value) => GetStorage().write(_key, value);

  // cek apakan data yang diingidnkan ada
  hasData() => GetStorage().hasData(_key);


}

class Glb{
  static final tanggalnya = DateTime.now().toString().split(" ")[0].obs;
}