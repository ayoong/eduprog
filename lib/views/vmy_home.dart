import 'package:eduprog/controllers/val.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum pilihan { all, day, night }

class VMyHome extends StatelessWidget {
  VMyHome({Key? key}) : super(key: key);

  final dipilih = pilihan.all.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan, title: Text("PT ARUTMIN")),
        body: SafeArea(
            child: Column(
          children: [
            // Text(Val.user().get().toString()),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                  child: Text(
                    'Data Timbangan PerHari',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.snackbar("info", "test di pencet");
                  },
                  icon: Icon(Icons.refresh, color: Colors.cyan),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white),
                  TextButton(
                      onPressed: () {},
                      child: Text('2021-11-24',
                          style: TextStyle(color: Colors.white))),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Text(
                        "Cari",
                      ))
                ],
              ),
            ),
            // ini yang baru ris
            Obx(() => Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          value: dipilih.value,
                          groupValue: pilihan.all,
                          onChanged: (hasil){
                            dipilih.value = pilihan.all;
                          }
                      ),
                      Text("All"),
                      Radio(
                          value: dipilih.value,
                          groupValue: pilihan.day,
                          onChanged: (hasil){
                            dipilih.value = pilihan.day;
                          }
                      ),
                      Text("Day"),
                      Radio(
                          value: dipilih.value,
                          groupValue: pilihan.night,
                          onChanged: (hasil){
                            dipilih.value = pilihan.night;
                          }
                      ),
                      Text("Night"),
                    ],
                  ),
                )),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Radio(
            //         value: value,
            //         groupValue: groupValue,
            //         onChanged: onChanged
            //       )
            //     ],
            //   ),
            // ),
            Flexible(child: ListView(children: []))
          ],
        )));
  }
}
