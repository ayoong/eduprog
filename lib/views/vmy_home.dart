import 'package:eduprog/views/vbar_chart.dart';
import 'package:eduprog/views/vbulan.dart';
import 'package:eduprog/views/vtanggal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VMyHome extends StatelessWidget {
  VMyHome({Key? key}) : super(key: key);
  final index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("PT ARUTMIN"),
        actions: [
          IconButton(
            onPressed: () => Get.to(
              VBarChart(),
            ),
            icon: const Icon(Icons.bar_chart),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: index.value,
            children: [VTanggal(), VBulan()],
          ),
        ),
      ),
    );
  }

  Widget bottomNav() => Obx(
        () => BottomNavigationBar(
          currentIndex: index.value,
          onTap: (value) => index.value = value,
          items: const[
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range_outlined), label: "Date"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range_outlined), label: "Month")
          ],
        ),
      );
}
