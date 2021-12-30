// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/akuntan/laporanLR/akuntan_page_nota_detail.dart';
// import 'package:intl/intl.dart';

// int totalPenjualan = 0;

// // ignore: must_be_immutable
// class WidgetListNota extends StatefulWidget {
//   var textHeaderListNota, listParameter;
//   WidgetListNota({Key key, this.textHeaderListNota, this.listParameter})
//       : super(key: key);

//   @override
//   _WidgetListNotaState createState() => _WidgetListNotaState();
// }

// class _WidgetListNotaState extends State<WidgetListNota> {
//   var numberFormatRp = new NumberFormat("#,##0", "id_ID");
//   Widget widgetListObat(listNotaPenjualans, textHeaderListNota) {
//     totalPenjualan = 0;
//     if (listNotaPenjualans.length > 0) {
//       return ExpansionTile(title: Text('$textHeaderListNota'), children: [
//         ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: listNotaPenjualans.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.black,
//                           // width: 3.0,
//                         ),
//                       ),
//                     ),
//                     child: ListTile(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => AkuntanVNoNota()));
//                       },
//                       // leading: Text(
//                       //     '${listNotaPenjualans[index].tgl_transaksi.toString().substring(0, 10)}'),
//                       title: Center(
//                         child: Text(
//                             '${listNotaPenjualans[index].tglTransaksi.toString().substring(0, 10)}'),
//                       ),
//                       // subtitle: Text(
//                       //     'Rp ${numberFormatRp.format(listNotaPenjualans[index].total_harga)}'),
//                     ),
//                   ));
//             }),
//       ]);
//     } else {
//       return Column(
//         children: [
//           ExpansionTile(
//             title: Text('Daftar Nota'),
//             children: [
//               ListTile(
//                 title: Text('tidak ada nota'),
//               )
//             ],
//           )
//         ],
//       );
//     }
//   }

//   Widget widgetTextTotalPenjualanObat(
//     listNotaPenjualans,
//   ) {
//     if (listNotaPenjualans.length > 0) {
//       //print('ListPenjualanObat.length: ${listNotaPenjualans.length}');
//       for (var i = 0; i < listNotaPenjualans.length; i++) {
//         totalPenjualan += listNotaPenjualans[i].total_harga;
//       }
//       //print(total.toString());
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//             title: Text(
//                 'Total ${widget.textHeaderListNota} Rp ${numberFormatRp.format(totalPenjualan)}')),
//       );
//     } else {
//       return Column(
//         children: [
//           ListTile(
//             title: Text('tidak ada total nota'),
//           )
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         widgetListObat(widget.listParameter, widget.textHeaderListNota),
//         widgetTextTotalPenjualanObat(widget.listParameter),
//       ],
//     );
//   }
// }
