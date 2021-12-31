import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_fetch_penjualan_obat.dart';
import 'package:intl/intl.dart';
import 'akuntan_list_nota_obat.dart';

// ignore: must_be_immutable
class WidgetTglPnjlnObat extends StatefulWidget {
  final Function() notifyParent;
  var tgl_penjualanObat;
  WidgetTglPnjlnObat({Key key, this.tgl_penjualanObat, this.notifyParent})
      : super(key: key);

  @override
  _WidgetTglPnjlnObatState createState() => _WidgetTglPnjlnObatState();
}

class _WidgetTglPnjlnObatState extends State<WidgetTglPnjlnObat> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObat() {
    // fetchPenjualan.totalPenjualan = 0;
    if (listPjlnTglObats.length > 0) {
      return ExpansionTile(title: Text('Penjualan Obat'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listPjlnTglObats.length,
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
                            builder: (context) => WidgetListNotaPjlnObat(
                                  tgl_transaksi: listPjlnTglObats[index]
                                      .tgl_transaksi
                                      .substring(0, 10),
                                )));
                      },
                      title: Center(
                        child: Text(
                            '${listPjlnTglObats[index].tgl_transaksi.substring(0, 10)} ' +
                                '| Rp ${numberFormatRp.format(listPjlnTglObats[index].totalHarga)}'),
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

  Widget widgetTextTotalPenjualanObat() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text(
              'Total Penjualan Obat Rp ${numberFormatRp.format(TextTotalPenjualanObat)}\n')),
    );
  }

//baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    listPjlnTglObats.clear();
    // //print('listPenjualanObats: ${listPenjualanObats.length}');
    //harus ada resep apoteker id di kasir
    Future<String> data = fetchDataVPjlnTglObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ////print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        listPjlnTglObats.add(pjlnObtNota);
      }
      setState(() {
        WidgetTglPnjlnObat();
      });
    }).then((value) {
      Future<String> data2 = fetchDataVPjlnObatTotal(tgl);
      data2.then((value2) {
        Map json = jsonDecode(value2);
        for (var i in json['data']) {
          AkuntanVPenjualanNotaObatTotal ttl =
              AkuntanVPenjualanNotaObatTotal.fromJson(i);
          TextTotalPenjualanObat = ttl.text_total_pejualan;
          print('TextTotalPenjualanObat $TextTotalPenjualanObat');
          // fetchPenjualan.totalPenjualan = ttl.text_total_pejualan;

          // //print('fetchDataVPjlnObatTotal ${fetchPenjualan.totalPenjualan}');
        }
        setState(() {
          widgetTextTotalPenjualanObat();
        });
      });
    });
  }

  var TextTotalPenjualanObat = 0;

  @override
  void initState() {
    print('set state pjln obat ${widget.tgl_penjualanObat}');
    AkunanBacaDataPenjualanObat(widget.tgl_penjualanObat);
    super.initState();
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
