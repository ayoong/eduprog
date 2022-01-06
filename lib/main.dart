import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:eduprog/views/vsplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main()async {

  // untuk validasi penyimpanan data sementara
  // contoh untuk meyimpan user ataupun session atau token
  await GetStorage.init();

  // untuk run aplikasi saat pertama run
  runApp(const MyApp());
}


// usahakan untuk setiap pembuatan class widget gunakan stateless widget
// untuk penghematam memory
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.zoom,
      debugShowCheckedModeBanner: false,
      // setelah aplikasi run akan langsung memunculkan halaman splash screen
      home: const DoubleBack(
        message: "yakin mau keluar ? kalo iya tekan back lagi",
        child: const VSplash()
      ),
      builder: EasyLoading.init(),
    );
  }
}