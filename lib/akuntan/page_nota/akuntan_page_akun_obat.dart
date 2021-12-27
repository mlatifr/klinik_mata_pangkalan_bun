import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart'
    as fetchPenjualan;
import 'package:intl/intl.dart';
import 'akuntan_fetch_penjualan_nota.dart';
import 'akuntan_page_akun_obat_nota.dart';

// ignore: must_be_immutable
class WidgetAkunObat extends StatefulWidget {
  var textHeaderPenjualanObat, totalPenjualan;
  WidgetAkunObat({Key key, this.textHeaderPenjualanObat, this.totalPenjualan})
      : super(key: key);

  @override
  _WidgetAkunObatState createState() => _WidgetAkunObatState();
}

class _WidgetAkunObatState extends State<WidgetAkunObat> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObat(plistPenjualanObats, textHeaderPenjualanObat) {
    fetchPenjualan.totalPenjualan = 0;
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
                          // width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WidgetAkunObatNota(
                                  tgl_transaksi: plistPenjualanObats[index]
                                      .tgl_transaksi
                                      .substring(0, 10),
                                )));
                      },
                      title: Center(
                        child: Text(
                            '${plistPenjualanObats[index].tgl_transaksi.substring(0, 10)}'),
                      ),
                    ),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          Text('Penjualan Obat'),
        ],
      );
    }
  }

  Widget widgetTextTotalPenjualanObat(totalPenjualan) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text(
              'Total Penjualan Obat Rp ${numberFormatRp.format(totalPenjualan)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListObat(listPjlnTglObats, widget.textHeaderPenjualanObat),
        widgetTextTotalPenjualanObat(widget.totalPenjualan),
      ],
    );
  }
}
