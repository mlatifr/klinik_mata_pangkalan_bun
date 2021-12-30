// // ignore_for_file: unused_import

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
// import 'package:flutter_application_1/akuntan/page_nota/akuntan_widget_list_nota.dart';
// import 'package:intl/intl.dart';

// class AkuntanVNoNota extends StatefulWidget {
//   const AkuntanVNoNota({Key key}) : super(key: key);

//   @override
//   _AkuntanVNoNotaState createState() => _AkuntanVNoNotaState();
// }

// class _AkuntanVNoNotaState extends State<AkuntanVNoNota> {
//   var numberFormatRp = new NumberFormat("#,##0", "id_ID");

// //baca data nota akun tindakan
// // ignore: non_constant_identifier_names
//   AkunanBacaDataListNota(tgl) {
//     print('listPenjualanTindakans before: ${listPenjualanTindakans.length}');
//     if (listPenjualanTindakans.isNotEmpty) {
//       listPenjualanTindakans.clear();
//     }
//     print('listPenjualanTindakans after: ${listPenjualanTindakans.length}');
//     Future<String> data = fetchDataVNotaPenjualan(tgl);
//     data.then((value) {
//       //Mengubah json menjadi Array
//       // ignore: unused_local_variable
//       Map json = jsonDecode(value);
//       for (var i in json['data']) {
//         print(i);
//         AkuntanVNotaPenjualan pjlnTdkn = AkuntanVNotaPenjualan.fromJson(i);
//         listNotaPenjualans.add(pjlnTdkn);
//       }
//       setState(() {
//         WidgetListNota(
//           listParameter: listNotaPenjualans,
//           textHeaderListNota: 'Daftar Nota',
//         );
//       });
//     });
//   }

//   var controllerdate = TextEditingController();

//   @override
//   void initState() {
//     DateTime now = new DateTime.now();
//     DateTime date = new DateTime(now.year, now.month, now.day);
//     //print(date);
//     controllerdate.text = date.toString().substring(0, 7);
//     (controllerdate.text);
//     AkunanBacaDataListNota(controllerdate.text);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text("Laporan Laba Rugi"),
//             leading: new IconButton(
//               icon: new Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           body: ListView(
//             children: [
//               WidgetListNota(
//                 listParameter: listNotaPenjualans,
//                 textHeaderListNota: 'Daftar Nota',
//               ),
//               Divider(),
//               // Text("Pendapatan: ${listPenjualanTindakans.length}"),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//                     },
//                     child: Text('Laba Bersih')),
//               ),
//             ],
//           )),
//     );
//   }
// }
