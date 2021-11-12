import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

class WidgetAkunObat extends StatefulWidget {
  const WidgetAkunObat({Key key}) : super(key: key);

  @override
  _WidgetAkunObatState createState() => _WidgetAkunObatState();
}

class _WidgetAkunObatState extends State<WidgetAkunObat> {
  
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObat() {
    if (listPenjualanObats.length > 0) {
      return ExpansionTile(title: Text('Daftar Penjualan Obat'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listPenjualanObats.length,
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
                      title: Text('${listPenjualanObats[index].nama}'),
                      subtitle: Text(
                          '${listPenjualanObats[index].tglResep.substring(0, 10)}\n${listPenjualanObats[index].jumlah} x ${numberFormatRp.format(int.parse(listPenjualanObats[index].harga))} |  Total:Rp ${numberFormatRp.format(listPenjualanObats[index].totalHarga)}'),
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

  Widget widgetTextTotalPenjualanObat() {
    int total = 0;
    if (listPenjualanObats.length > 0) {
      print('ListPenjualanObat.length: ${listPenjualanObats.length}');
      for (var i = 0; i < listPenjualanObats.length; i++) {
        total += listPenjualanObats[i].totalHarga;
      }
      print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Obat Rp ${numberFormatRp.format(total)}')),
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
        widgetListObat(),
        widgetTextTotalPenjualanObat(),
      ],
    );
  }
}
