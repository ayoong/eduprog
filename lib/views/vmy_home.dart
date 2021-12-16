import 'package:eduprog/controllers/conn.dart';
import 'package:eduprog/controllers/model.dart';
import 'package:eduprog/controllers/val.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';

enum pilihanSiangAtauMalam { all, day, night }

class VMyHome extends StatelessWidget {
  VMyHome({Key? key}) : super(key: key);

  final dipilih = pilihanSiangAtauMalam.all.obs;
  final tanggalnya = "".obs;
  final listTransaksi = <MTransaksi>[].obs;
  final listTransaksiJson = [].obs;

  @override
  Widget build(BuildContext context) {
    ketikaDibuka();

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan, title: Text("PT ARUTMIN")),
        body: SafeArea(
            child: Column(
          children: [
            // Text(Val.user().get().toString()),
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
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse("2020-01-01"),
                        lastDate: DateTime.now(),
                      );

                      if (tanggal != null) {
                        tanggalnya.value = tanggal.toString().split(" ")[0];
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
            Obx(
              () => Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: dipilih.value,
                        groupValue: pilihanSiangAtauMalam.all,
                        onChanged: (hasil) {
                          dipilih.value = pilihanSiangAtauMalam.all;
                        }),
                    Text("All"),
                    Radio(
                        value: dipilih.value,
                        groupValue: pilihanSiangAtauMalam.day,
                        onChanged: (hasil) {
                          dipilih.value = pilihanSiangAtauMalam.day;
                        }),
                    Text("Day"),
                    Radio(
                        value: dipilih.value,
                        groupValue: pilihanSiangAtauMalam.night,
                        onChanged: (hasil) {
                          dipilih.value = pilihanSiangAtauMalam.night;
                        }),
                    Text("Night"),
                  ],
                ),
              ),
            ),
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
            Flexible(
                child: FutureBuilder(
                  future: ketikaDibuka(),
              builder: (context, snapshot) => snapshot.connectionState !=
                      ConnectionState.done
                  ? Text("loaading ...")
                  : Obx(() => Column(
                    children: [
                      Text(listTransaksi.length.toString()),
                      Flexible(
                        child: JsonTable(
                              listTransaksiJson,
                              allowRowHighlight: true,
                              // showColumnToggle: true,
                              // paginationRowCount: 11,
                              rowHighlightColor: Colors.grey[200],
                              columns: [
                                JsonTableColumn(
                                  "dt",
                                  label: "DT",
                                ),
                                JsonTableColumn(
                                  "supplier",
                                  label: "Supplier",
                                ),
                                JsonTableColumn("jam_in",
                                    label: "Jam In",
                                    valueBuilder: (value) => siangAtauMalam(
                                          value
                                              .toString()
                                              .split("T")[1]
                                              .split(".")[0],
                                        )),
                                JsonTableColumn(
                                  "netto_rekon",
                                  label: "Netto Rekon",
                                ),
                              ],
                              tableHeaderBuilder: (header) => Container(
                                padding: EdgeInsets.all(14),
                                color: Colors.cyan,
                                child: Text(
                                  header.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              tableCellBuilder: (value) => Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey.shade200))),
                                width: Get.width / 4.2,
                                padding: EdgeInsets.all(8),
                                child: Text(value),
                              ),
                            ),
                      ),
                    ],
                  )),
            )

                //     Column(
                //   children: [
                //     Table(
                //       children: [
                //         TableRow(
                //           decoration: BoxDecoration(
                //             color: Colors.cyan,
                //           ),
                //           children: [
                //             TableCell(
                //               child: Container(
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   "DT",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             ),
                //             TableCell(
                //               child: Container(
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   "Supplier",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             ),
                //             TableCell(
                //               child: Container(
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   "Jam In",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             ),
                //             TableCell(
                //               child: Container(
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   "Netto Recon",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     ),
                //     Flexible(
                //       child: ListView(
                //         children: [
                //           Table(
                //             children: [
                //               for (final tr in listTransaksi)
                //                 TableRow(children: [
                //                   TableCell(
                //                     child: Container(
                //                       padding: EdgeInsets.all(8),
                //                       child: Text(tr.dt.toString()),
                //                     ),
                //                   ),
                //                   TableCell(
                //                     child: Container(
                //                       padding: EdgeInsets.all(8),
                //                       child: Text(tr.supplier.toString()),
                //                     ),
                //                   ),
                //                   TableCell(
                //                     child: Container(
                //                       padding: EdgeInsets.all(8),
                //                       child:
                //                           Text(tr.jamIn.toString().split("T")[0]),
                //                     ),
                //                   ),
                //                   TableCell(
                //                     child: Container(
                //                       padding: EdgeInsets.all(8),
                //                       child: Text(
                //                       tr.nettoRekon.toString(),
                //                     ),
                //                     )
                //                   ),
                //                 ],)
                //             ],
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // )

                // ListView(
                //   children: [
                //     for(var a in listTransaksi)
                //     Row(
                //       children: [
                //         Text(a.dt.toString()),
                //         Text(a.supplier.toString())
                //       ],
                //     )
                //   ],
                // ),
                )
          ],
        )));
  }

  siangAtauMalam(String jam) {
    return int.parse(jam.split(":")[0]) > 17 ? "m_$jam" : "s_$jam";
  }

  ketikaDibuka() async {
    tanggalnya.value = DateTime.now().toString().split(" ")[0];
    EasyLoading.showInfo("loading");
    final transaksi = await Conn().transaksi();
    listTransaksiJson.assignAll(transaksi.body);

    listTransaksi.assignAll(
        List.from(transaksi.body).map((e) => MTransaksi.fromJson(e)));

    await 2.delay();
    EasyLoading.dismiss();

    dipilih.listen((p0) {
      // print(dipilih.value);
      // List<MTransaksi> ls = List.from(listTransaksi);
      if (dipilih.value == pilihanSiangAtauMalam.all) {
        listTransaksi.assignAll(
            List.from(transaksi.body).map((e) => MTransaksi.fromJson(e)));
        return;
      }

      if (dipilih.value == pilihanSiangAtauMalam.day) {
        listTransaksi.assignAll(List.from(transaksi.body)
            .map((e) => MTransaksi.fromJson(e))
            .toList()
            .where((element) =>
                int.parse(
                    element.jamIn.toString().split("T")[1].split(":")[0]) <
                17));
        return;
      }

      if (dipilih.value == pilihanSiangAtauMalam.night) {
        listTransaksi.assignAll(List.from(transaksi.body)
            .map((e) => MTransaksi.fromJson(e))
            .toList()
            .where((element) =>
                int.parse(
                    element.jamIn.toString().split("T")[1].split(":")[0]) >
                17));
        return;
      }
    });
  }
}
