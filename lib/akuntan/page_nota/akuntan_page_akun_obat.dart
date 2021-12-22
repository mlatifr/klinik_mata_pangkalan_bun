import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetAkunObat extends StatefulWidget {
  var textHeaderPenjualanObat;
  WidgetAkunObat({Key key, this.textHeaderPenjualanObat}) : super(key: key);

  @override
  _WidgetAkunObatState createState() => _WidgetAkunObatState();
}

class _WidgetAkunObatState extends State<WidgetAkunObat> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObat(plistPenjualanObats, textHeaderPenjualanObat) {
    totalPenjualan = 0;
    if (plistPenjualanObats.length > 0) {
      return ExpansionTile(title: Text('$textHeaderPenjualanObat'), children: [
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
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                          '${plistPenjualanObats[index].tglResep.substring(0, 10)}'),
                      subtitle: Text(
                          '${plistPenjualanObats[index].jumlah} x ${numberFormatRp.format(int.parse(plistPenjualanObats[index].harga))} |  Total:Rp ${numberFormatRp.format(plistPenjualanObats[index].totalHarga)}'),
                    ),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
      );
    }
  }

  Widget widgetTextTotalPenjualanObat(
    plistPenjualanObats,
  ) {
    if (plistPenjualanObats.length > 0) {
      //print('ListPenjualanObat.length: ${plistPenjualanObats.length}');
      for (var i = 0; i < plistPenjualanObats.length; i++) {
        totalPenjualan += plistPenjualanObats[i].totalHarga;
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Obat Rp ${numberFormatRp.format(totalPenjualan)}')),
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
    return Column(
      children: [
        widgetListObat(listPenjualanObats, widget.textHeaderPenjualanObat),
        widgetTextTotalPenjualanObat(listPenjualanObats),
      ],
    );
  }
}
