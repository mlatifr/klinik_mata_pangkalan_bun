import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

int totalHPPObat = 0;

class WidgetAkunHPPObat extends StatefulWidget {
  WidgetAkunHPPObat({Key key}) : super(key: key);

  @override
  _WidgetAkunHPPObatState createState() => _WidgetAkunHPPObatState();
}

class _WidgetAkunHPPObatState extends State<WidgetAkunHPPObat> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListHPPObat(
    plistPenjualanObats,
  ) {
    totalHPPObat = 0;
    if (plistPenjualanObats.length > 0) {
      return Column(
        children: [
          ExpansionTile(title: Text('Penjualan HPP obat'), children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: plistPenjualanObats.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {},
                          title: Center(
                            child: Text(
                                '${plistPenjualanObats[index].tgl_transaksi.toString().substring(0, 10)}'),
                          ),
                        ),
                      ));
                }),
          ]),
          widgetTextTotalHPPObat(listHppObats),
        ],
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          Text('HPP Penjualan Obat'),
        ],
      );
    }
  }

  Widget widgetTextTotalHPPObat(
    plistPenjualanObats,
  ) {
    if (plistPenjualanObats.length > 0) {
      // print('ListPenjualanObat.length: ${plistPenjualanObats.length}');
      for (var i = 0; i < plistPenjualanObats.length; i++) {
        totalHPPObat += plistPenjualanObats[i].totalHarga;
      }
      // print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total HPP Obat Rp ${numberFormatRp.format(totalHPPObat)}')),
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          // Text('data tidak ditemukan'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetListHPPObat(listHppObats);
  }
}
