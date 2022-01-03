import 'package:eduprog/controllers/conn.dart';
import 'package:eduprog/controllers/model.dart';
import 'package:eduprog/controllers/val.dart';
import 'package:eduprog/views/vbar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum pilihanSiangAtauMalam { all, day, night }

class VBulan extends StatelessWidget {
  VBulan({Key? key}) : super(key: key);

  final dipilih = pilihanSiangAtauMalam.all.obs;
  final tanggalnya = DateTime.now().toString().split(" ")[0].obs;
  final listTransaksiPerbulan = <MTablePerBulan>[].obs;
  final listTransaksiJson = [].obs;
  final ritAndTonase = {}.obs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
          future: ketikaDibuka(),
          builder: (context, snapshot) => Visibility(
            visible: snapshot.connectionState != ConnectionState.done,
            child: const Text("loading ..."),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Data Timbangan Perbulan',
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
                icon: const Icon(Icons.refresh, color: Colors.cyan),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.cyan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search, color: Colors.white),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    tanggalnya.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  final tanggal = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(tanggalnya.value.toString()),
                    firstDate: DateTime.parse("2020-01-01"),
                    lastDate: DateTime.now(),
                  );

                  if (tanggal != null) {
                    tanggalnya.value = tanggal.toString().split(" ")[0];
                    Val.perBulan().set(tanggalnya.value);
                    await loadTransaksi();
                    await loadRitAndTodnase();
                  }
                },
                child: const Text(
                  "Cari",
                ),
              )
            ],
          ),
        ),
        // ini yang baru ris
        Container(
          padding: const EdgeInsets.all(8),
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
                const Text("All"),
                Radio(
                  value: dipilih.value,
                  groupValue: pilihanSiangAtauMalam.day,
                  onChanged: (hasil) {
                    dipilih.value = pilihanSiangAtauMalam.day;
                  },
                ),
                const Text("Day"),
                Radio(
                  value: dipilih.value,
                  groupValue: pilihanSiangAtauMalam.night,
                  onChanged: (hasil) {
                    print(dipilih);
                    dipilih.value = pilihanSiangAtauMalam.night;
                  },
                ),
                const Text("Night"),
              ],
            ),
          ),
        ),
        Obx(
          () => Container(
            color: Colors.cyan,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "RIT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ritAndTonase['rit'] == null? "0,0": NumberFormat.simpleCurrency(locale: "id-ID").format(ritAndTonase['rit']).replaceAll("Rp", "").replaceAll(",00", ",0"),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "TONASE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ritAndTonase['tonase'] == null? "0,0": NumberFormat.simpleCurrency(locale: "id-Id").format(ritAndTonase['tonase']).replaceAll("Rp", "").replaceAll(",00", ",0"),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.cyan,
          child: Row(
            children: const [
              Expanded(
                  child: Text(
                "Tanggal",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Ritase",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Tonase",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
            ],
          ),
        ),
        Obx(
          () => listTransaksiPerbulan.isEmpty
              ? const Center(
                  child: Text("Data Kosong"),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      for (final trx in listTransaksiPerbulan)
                        Visibility(
                          // visible: dipilih.value.index == 2 &&
                          //         trx.tanggalShift == "MALAM" ||
                          //     dipilih.value.index == 1 &&
                          //         trx.tanggalShift == "SIANG" ||
                          //     dipilih.value.index == 0,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    trx.tanggal.toString().split("T")[0].toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                   padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    NumberFormat.simpleCurrency(locale: "id-ID").format(trx.rit).replaceAll("Rp", "").replaceAll(",00", ",0"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                   padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    NumberFormat.simpleCurrency(locale: "id-ID").format(trx.tonase).replaceAll("Rp", "").replaceAll(",00", ",0"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
        )
      ],
    );
  }

  loadTransaksi() async {
    EasyLoading.showInfo("loading");
    if(Val.perBulan().hasData()) tanggalnya.value = Val.perBulan().get();
    final transaksi = await Conn().transaksiPerBulan(tanggalnya.value);
    listTransaksiJson.assignAll(transaksi.body);

    listTransaksiPerbulan.assignAll(
        List.from(transaksi.body).map((e) => MTablePerBulan.fromJson(e)));

    await 2.delay();
    EasyLoading.dismiss();
  }

  ketikaDibuka() async {
    await loadTransaksi();
    loadRitAndTodnase();
  }

  loadRitAndTodnase()async{
    final rt = await Conn().ritTonasePerBulan(tanggalnya.value);
    ritAndTonase.assignAll(rt.body);
  }
}
