import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VBulan extends StatefulWidget {
  const VBulan({ Key? key }) : super(key: key);

  @override
  _VBulanState createState() => _VBulanState();
}

class _VBulanState extends State<VBulan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("ini bulan masih kosong")
        ],
      ),
    );
  }
}