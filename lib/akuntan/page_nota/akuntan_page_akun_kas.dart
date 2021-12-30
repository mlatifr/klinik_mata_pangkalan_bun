// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
// import 'package:intl/intl.dart';

// int totalAkunKas = 0;

// // ignore: must_be_immutable
// class WidgetAkunKas extends StatefulWidget {
//   var pTextListKas;
//   WidgetAkunKas({Key key, this.pTextListKas}) : super(key: key);

//   @override
//   _WidgetAkunKasState createState() => _WidgetAkunKasState();
// }

// class _WidgetAkunKasState extends State<WidgetAkunKas> {
//   var numberFormatRp = new NumberFormat("#,##0", "id_ID");
//   Widget widgetListKas(pTextListKas) {
//     totalAkunKas = 0;
//     if (listAkunKass.length > 0) {
//       return ExpansionTile(title: Text('$pTextListKas'), children: [
//         ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: listAkunKass.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.black,
//                           width: 3.0,
//                         ),
//                       ),
//                     ),
//                     child: ListTile(
//                       onTap: () {},
//                       leading: CircleAvatar(
//                         child: Text('${index + 1}'),
//                       ),
//                       title: Text('${listAkunKass[index].namaPasien}'),
//                       subtitle: Text(
//                           '${listAkunKass[index].tgl_transaksi.toString().substring(0, 10)} \nRp ${numberFormatRp.format(listAkunKass[index].harga)}'),
//                     ),
//                   ));
//             }),
//       ]);
//     } else
//       return Container();
//   }

//   Widget widgetTextTotalKas() {
//     if (listAkunKass.length > 0) {
//       //print('ListPenjualanJasmed.length: ${listAkunKass.length}');
//       for (var i = 0; i < listAkunKass.length; i++) {
//         totalAkunKas += listAkunKass[i].harga;
//       }
//       //print(total.toString());
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//             title: Text(
//                 'Total Akun Kas Rp ${numberFormatRp.format(totalAkunKas)}')),
//       );
//     } else
//       return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         widgetListKas(widget.pTextListKas),
//         widgetTextTotalKas(),
//       ],
//     );
//   }
// }
