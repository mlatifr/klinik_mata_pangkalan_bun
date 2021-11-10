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
    if (ListPenjualanObats.length > 0) {
      return ExpansionTile(title: Text('Daftar Penjualan Obat'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ListPenjualanObats.length,
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
                      title: Text('${ListPenjualanObats[index].nama}'),
                      subtitle: Text(
                          '${ListPenjualanObats[index].tgl_resep.substring(0, 10)}\n${ListPenjualanObats[index].jumlah} x ${numberFormatRp.format(int.parse(ListPenjualanObats[index].harga))} |  Total:Rp ${numberFormatRp.format(ListPenjualanObats[index].total_harga)}'),
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
    if (ListPenjualanObats.length > 0) {
      print('ListPenjualanObat.length: ${ListPenjualanObats.length}');
      for (var i = 0; i < ListPenjualanObats.length; i++) {
        total += ListPenjualanObats[i].total_harga;
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
