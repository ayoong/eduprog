import 'package:eduprog/controllers/val.dart';
import 'package:eduprog/views/login.dart';
import 'package:eduprog/views/vmy_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VSplash extends StatelessWidget {
  const VSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: Get.width,//untuk dapetin lebar layar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('EDU PROG',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),

          FutureBuilder(
            future: onLoad(),
            builder: (context, snapshot) => 
            Visibility(
              visible: snapshot.connectionState != ConnectionState.done,
              child: Center(child: Text("loading ...."),)
            )
          )
        ],
      ),
    ));
  }

  // setelah aplikasi runing bagian ini akan memproses harus kemana selanjutnya
  // contoh jika sudah login maka akan diarahkan ke halaman utama 
  // jika belumlogin akan diarahkan ke halaman login
  Future<void> onLoad()async{
    
    // diberikan waktu jeda 4 detik sebelum diarahkan ke halaman berikutnya
    await 4.delay();

    // melakukan pengecekan apakah user sudah login atau belum 
    // ditandai dengan adanya data user di penyimpanan sementara
    if(Val.user().hasData()){

      // bagian ini jika ada data user artinya user sudah login
      // maka user akan diarahkan ke halaman utama
      Get.off(VMyHome());

      // return artinya proses cukup sampai disini kodi dibawahnya setelah ini
      // tidak boleh di eksekusi , alias {else}
      return;
    }

    // jika user belumpempunyai data yang tersimpan artinya user belum login
    // langsung diarahkan ke halaman login
    Get.off(VLogin());

  }
}
