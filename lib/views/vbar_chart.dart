// import 'package:charts_flutter/flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class VBarChart extends StatelessWidget {
//   const VBarChart({ Key? key }) : super(key: key);

//   final

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("BarChart"),
//       ),
//       body: SafeArea(
//         child: Column(
//       children: [
//         BarChart(seriesList)
//       ],
//     )
//       ),
//     )
//     ;
//   }
// }

/// Vertical bar chart with bar label renderer example.
import 'package:charts_flutter/flutter.dart'hide Axis;
import 'package:eduprog/controllers/conn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/painting/basic_types.dart';

class VBarChart extends StatelessWidget {
  // final List<charts.Series>? seriesList = [
  //   charts.Series(id: id, data: data, domainFn: domainFn, measureFn: measureFn)
  // ];
  // final bool? animate;
  final lsChart = <Series<OrdinalSales, String>>[].obs;
  final animeteNya = true.obs;

  VBarChart({
    Key? key,
  }) : super(key: key);

  /// Creates a [BarChart] with sample data and no transition.
  // factory VBarChart.withSampleData() {
  //   return VBarChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit,
  // it will draw outside of the bar.
  // Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Bar"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
            future: onLoad(),
            builder: (a,b) => 
            Visibility(
              visible: b.connectionState != ConnectionState.done,
              child: Text("loading")
            )
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(8),
                width: 2000,
                child: Obx(
                  () => 
                  lsChart.isEmpty? Text("loading"): BarChart(
                  List.from(lsChart),
                  animate: animeteNya.value,
                  // Set a bar label decorator.
                  // Example configuring different styles for inside/outside:
                  //       barRendererDecorator: new charts.BarLabelDecorator(
                  //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
                  //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
                  barRendererDecorator: BarLabelDecorator<String>(),
                  domainAxis: const OrdinalAxisSpec(),
                )
                )
                ,
              ),
            ),
          )
        ],
      )),
    );
  }

  /// Create one series with sample hard coded data.
  // static List<Series<OrdinalSales, String>> _createSampleData() {
  //   final data = [
  //     OrdinalSales('2014', 5),
  //     OrdinalSales('2015', 25),
  //     OrdinalSales('2016', 100),
  //     OrdinalSales('2017', 75),
  //   ];

  //   return [
  //     Series<OrdinalSales, String>(
  //         id: 'Sales',
  //         domainFn: (OrdinalSales sales, _) => sales.jam,
  //         measureFn: (OrdinalSales sales, _) => sales.net,
  //         data: data,
  //         // Set a label accessor to control the text of the bar label.
  //         labelAccessorFn: (OrdinalSales sales, _) =>
  //             '\$${sales.net.toString()}')
  //   ];
  // }

  Future onLoad()async{
    final res = await Conn().chart();
    final data = List.from(res.body).map((e) => OrdinalSales("${e['jam']} - ${e['jam'] +1}", e['net'])).toList();
    final ls = [
      Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.jam,
          measureFn: (OrdinalSales sales, _) => sales.net,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
              '\Rp${sales.net.toString()}')
    ];
    
    print(res.body);

    lsChart.assignAll(ls);
    
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String jam;
  final int net;

  OrdinalSales(this.jam, this.net);
}
