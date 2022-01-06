import 'dart:convert';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:eduprog/controllers/conn.dart';
import 'package:eduprog/controllers/val.dart';
import 'package:eduprog/views/vbar_chart.dart';
import 'package:eduprog/views/vbulan.dart';
import 'package:eduprog/views/vtanggal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VMyHome extends StatelessWidget {
  VMyHome({Key? key}) : super(key: key);
  final index = 0.obs;
  final jmTerakhir = {}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PT ARUTMIN"),
            FutureBuilder(
              future: onLoad(),
              builder: (context, snapshot) =>
                  snapshot.connectionState != ConnectionState.done
                      ? Text("...")
                      : Obx(() => Text(
                            jmTerakhir['jam'].toString().split("T")[1].toString().split(".")[0],
                            style: TextStyle(
                                fontSize: 14,
                                backgroundColor: Colors.cyan[800]),
                          )),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(
              VBarChart(tanggal: Glb.tanggalnya.value,),
            ),
            icon: const Icon(Icons.bar_chart),
          )
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(content: Text("yakin mau keluar ?"),),
        child: SafeArea(
          child: Obx(
            () => IndexedStack(
              index: index.value,
              children: [VTanggal(), VBulan()],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNav() => Obx(
        () => BottomNavigationBar(
          currentIndex: index.value,
          onTap: (value) => index.value = value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range_outlined), label: "Date"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range_outlined), label: "Month")
          ],
        ),
      );

  Future onLoad() async {
    EasyLoading.show(dismissOnTap: true, status: "load data");
    await 1.delay();
    final jm = await Conn().jamTerakhir();
    jmTerakhir.value = jm.body;

    EasyLoading.dismiss();
  }
}
