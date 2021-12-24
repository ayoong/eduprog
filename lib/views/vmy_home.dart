import 'package:eduprog/controllers/conn.dart';
import 'package:eduprog/controllers/model.dart';
import 'package:eduprog/controllers/val.dart';
import 'package:eduprog/views/vbar_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';

enum pilihanSiangAtauMalam { all, day, night }

class VMyHome extends StatelessWidget {
  VMyHome({Key? key}) : super(key: key);

  final dipilih = pilihanSiangAtauMalam.all.obs;
  final tanggalnya = DateTime.now().toString().split(" ")[0].obs;
  final listTransaksi = <MTransaksi>[].obs;
  final listTransaksiJson = [].obs;
  final ritAndTonase = {}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: 'day', icon: Icon(Icons.view_day, )),
        BottomNavigationBarItem(label: "month", icon: Icon(Icons.monitor_weight_outlined))
      ]),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("PT ARUTMIN"),
        actions: [
          IconButton(
              onPressed: () => Get.to(VBarChart()), icon: Icon(Icons.bar_chart))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: ketikaDibuka(),
              builder: (context, snapshot) => Visibility(
                visible: snapshot.connectionState != ConnectionState.done,
                child: Text("loading ..."),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
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
                    onPressed: () async {
                      print("saya di refresh");
                    },
                    icon: Icon(Icons.refresh, color: Colors.cyan),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        tanggalnya.value,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () async {
                      final tanggal = await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.parse(tanggalnya.value.toString()),
                        firstDate: DateTime.parse("2020-01-01"),
                        lastDate: DateTime.now(),
                      );

                      if (tanggal != null) {
                        tanggalnya.value = tanggal.toString().split(" ")[0];
                        print(tanggalnya.toString());
                        await loadTransaksi();
                      }
                    },
                    child: Text(
                      "Cari",
                    ),
                  )
                ],
              ),
            ),
            // ini yang baru ris
            Container(
              padding: EdgeInsets.all(8),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: dipilih.value,
                      groupValue: pilihanSiangAtauMalam.all,
                      onChanged: (hasil) {
                        dipilih.value = pilihanSiangAtauMalam.all;
                      },
                    ),
                    Text("All"),
                    Radio(
                      value: dipilih.value,
                      groupValue: pilihanSiangAtauMalam.day,
                      onChanged: (hasil) {
                        dipilih.value = pilihanSiangAtauMalam.day;
                      },
                    ),
                    Text("Day"),
                    Radio(
                      value: dipilih.value,
                      groupValue: pilihanSiangAtauMalam.night,
                      onChanged: (hasil) {
                        print(dipilih);
                        dipilih.value = pilihanSiangAtauMalam.night;
                      },
                    ),
                    Text("Night"),
                  ],
                ),
              ),
            ),
            Obx(() => Container(
                  color: Colors.cyan,
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "ROT",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(ritAndTonase['rit'].toString(),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "TONASE",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(ritAndTonase['tonase'].toString(),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),),
                SizedBox(
                  height: 30,
                ),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.cyan,
              child: Row(
                children: const [
                  Expanded(
                      child: Text(
                    "Dt",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Text(
                    "Supplier",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Text(
                    "Jam In",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  Expanded(
                      child: Text(
                    "Netto Rekon",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))
                ],
              ),
            ),
            Flexible(
              child: Obx(
                () => listTransaksi.isEmpty
                    ? Center(
                        child: Text("Data Kosong"),
                      )
                    : ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                for (final trx in listTransaksi)
                                  Visibility(
                                    visible: dipilih.value.index == 2 &&
                                            trx.tanggalShift == "MALAM" ||
                                        dipilih.value.index == 1 &&
                                            trx.tanggalShift == "SIANG" ||
                                        dipilih.value.index == 0,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            trx.dt.toString(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            trx.supplier.toString(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            trx.jamIn
                                                .toString()
                                                .split("T")[1]
                                                .toString()
                                                .split(".")[0],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            trx.nettoRekon.toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadTransaksi() async {
    EasyLoading.showInfo("loading");
    final transaksi = await Conn().transaksi(tanggalnya.value);
    listTransaksiJson.assignAll(transaksi.body);

    listTransaksi.assignAll(
        List.from(transaksi.body).map((e) => MTransaksi.fromJson(e)));

    await 2.delay();
    EasyLoading.dismiss();
  }

  ketikaDibuka() async {
    await loadTransaksi();
    final rt = await Conn().ritAndTonase();
    ritAndTonase.assignAll(rt.body);
  }
}
