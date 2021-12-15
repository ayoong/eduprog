import 'package:eduprog/controllers/val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VMyHome extends StatelessWidget {
  const VMyHome({Key? key}) : super(key: key);

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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700]),
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
                    onPressed: (){

                    }, 
                    child: Text('2021-11-24', style: TextStyle(color: Colors.white))
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                    ),
                    onPressed: (){

                    }, 
                    child: Text("Cari",)
                  )
                ],
              ),
            ),
            //  Container(
            // padding: EdgeInsets.all(8),
              
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(children: [
            //         Radio(
            //           groupValue: 1,
            //           value: 1,
            //           onChanged: (value){},
            //           ),
            //           SizedBox(width: 10.0,),
                      
            //           Text("ALL"),
            //       ],),
            Flexible(child: ListView(

              children:[

              ]
            ))
          ],
        )));
  }
}
