import 'package:eduprog/views/vsplash.dart';
import 'package:flutter/material.dart';
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
    return const GetMaterialApp(
      defaultTransition: Transition.zoom,
      debugShowCheckedModeBanner: false,
      // setelah aplikasi run akan langsung memunculkan halaman splash screen
      home: VSplash(),
    );
  }
}