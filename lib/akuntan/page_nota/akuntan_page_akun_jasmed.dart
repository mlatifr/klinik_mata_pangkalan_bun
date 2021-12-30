// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
// import 'package:intl/intl.dart';

// int totalBiayaKomisiJasmed = 0;

// // ignore: must_be_immutable
// class WidgetAkunJasmed extends StatefulWidget {
//   var pTextDaftarPenjualanJasmed;
//   WidgetAkunJasmed({Key key, this.pTextDaftarPenjualanJasmed})
//       : super(key: key);

//   @override
//   _WidgetAkunJasmedState createState() => _WidgetAkunJasmedState();
// }

// class _WidgetAkunJasmedState extends State<WidgetAkunJasmed> {
//   var numberFormatRp = new NumberFormat("#,##0", "id_ID");
//   Widget widgetListJasmed(pTextDaftarPenjualanJasmed) {
//     totalBiayaKomisiJasmed = 0;
//     if (listPenjualanJasmeds.length > 0) {
//       return ExpansionTile(
//           title: Text('$pTextDaftarPenjualanJasmed'),
//           children: [
//             ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: listPenjualanJasmeds.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(
//                               color: Colors.black,
//                               width: 3.0,
//                             ),
//                           ),
//                         ),
//                         child: ListTile(
//                           onTap: () {},
//                           leading: CircleAvatar(
//                             child: Text('${index + 1}'),
//                           ),
//                           title:
//                               Text('${listPenjualanJasmeds[index].namaPasien}'),
//                           subtitle: Text(
//                               '${listPenjualanJasmeds[index].tglResep} \nRp ${numberFormatRp.format(listPenjualanJasmeds[index].harga)}'),
//                         ),
//                       ));
//                 }),
//           ]);
//     } else
//       return Container();
//   }

//   Widget widgetTextTotalPenjualanJasmed() {
//     if (listPenjualanJasmeds.length > 0) {
//       //print('ListPenjualanJasmed.length: ${listPenjualanJasmeds.length}');
//       for (var i = 0; i < listPenjualanJasmeds.length; i++) {
//         totalBiayaKomisiJasmed += listPenjualanJasmeds[i].harga;
//       }
//       //print(total.toString());
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//             title: Text(
//                 'Total Penjualan Jasmed Rp ${numberFormatRp.format(totalBiayaKomisiJasmed)}')),
//       );
//     } else
//       return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         widgetListJasmed(widget.pTextDaftarPenjualanJasmed),
//         widgetTextTotalPenjualanJasmed(),
//       ],
//     );
//   }
// }
