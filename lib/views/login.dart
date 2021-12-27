import 'package:eduprog/controllers/conn.dart';
import 'package:eduprog/controllers/model.dart';
import 'package:eduprog/controllers/val.dart';
import 'package:eduprog/views/vtanggal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VLogin extends StatelessWidget {
  VLogin({Key? key}) : super(key: key);

  // untuk deklarasi bisa menggunakan class aslinya atau digantikan dengan final
  // pemilihan penggunaan final adalah untuk penghematan memory
  final controllerUserName = TextEditingController();
  final controllerUserPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                // list view adalah bagian yang bisa di scroll
                child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    child: Image.asset('assets/images/logopt.png',
                        width: 200, height: 200)),
                ListTile(
                  title: TextFormField(
                    controller: controllerUserName,
                    decoration: InputDecoration(
                        hintText: 'user name',
                        border: InputBorder.none,
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                  subtitle: Text(""),
                ),
                ListTile(
                  title: TextFormField(
                    controller: controllerUserPassword,
                    decoration: InputDecoration(
                        hintText: 'password',
                        border: InputBorder.none,
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                  subtitle: Text(""),
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(16),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: ketikaTombolLoginDiPencet,
                child: Container(
                  padding: EdgeInsets.all(10),
                  // double infinity untuk mengambil nilai space yang tersisa
                  // bisa juga menggunakan nilai tetap contoh : 100 atau 200 dan lainnya
                  // namun double infinity otomatis mengambil nilai space yang tersisa
                  width: double.infinity,
                  // gunakan centre jika ingin element otomatis ke tengah
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ketikaTombolLoginDiPencet() async {
    // penampungan sementara dari haril input user dan password
    // model ini disebut key value atau map atau jason
    // parameter key [user_name] parameter value [controllerUserName.text]
    // jika fugsinya untuk mengirimkan data , maka key harus sesuai dengan yang ada di database
    final model = {
      "user_name": controllerUserName.text,
      "user_password": controllerUserPassword.text
    };

    // ini untuk pengecekan jika user atau password salah satunya ada yang kosong
    // atau tidak diisi
    if (model.values.contains("")) {
      Get.snackbar("INFO", "User dan passwordnya jangan ada yang kosong ya!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // mencoba mengirimkan data login ke server
    final res = await Conn().login(model);

    // jika ada gangguan pada server maka anan memunculkan ifo
    if (!res.isOk) {
      Get.snackbar('info', 'server error');
      return;
    }

    // jika username atau password dalah , maka akan memunculkan info 
    // bahwa user atau password salah
    if(!res.body['success']){
      Get.dialog(
        AlertDialog(
          title: Text('info'),
          content: Text("username or password failed"),
          actions:[
            TextButton(onPressed: () => Get.back(), child: Text("OK"))
          ]
        ),
      
      );
    }


    // menyimpan data user setelah data didapatkan dari server
    Val.user().set(res.body['data']);


    // setelah data diskimpan . makan akan ber
    //
    //pindah halaman ke vmyhome()
    Get.off(VTanggal());
    

  }
}
