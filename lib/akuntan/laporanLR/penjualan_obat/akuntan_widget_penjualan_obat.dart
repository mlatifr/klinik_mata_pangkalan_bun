import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_fetch_penjualan_obat.dart';
import 'package:intl/intl.dart';
import 'akuntan_list_nota_obat.dart';

// ignore: must_be_immutable
class WidgetTglPnjlnObat extends StatefulWidget {
  final Stream<String> stream;
  WidgetTglPnjlnObat({Key key, this.stream}) : super(key: key);

  @override
  _WidgetTglPnjlnObatState createState() => _WidgetTglPnjlnObatState();
}

_WidgetTglPnjlnObatState globalObat = _WidgetTglPnjlnObatState();

class _WidgetTglPnjlnObatState extends State<WidgetTglPnjlnObat> {
  AkuntanBacaDataPenjualanObat(tgl) {
    listPjlnTglObats.clear();
    Future<String> data = fetchDataVPjlnTglObat(tgl);
    data.then((value) {
      if (value.toString().contains('success')) {
        //Mengubah json menjadi Array
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
          listPjlnTglObats.add(pjlnObtNota);
        }
      } else {
        listPjlnTglObats = [];
      }
    });
    Future<String> data2 = fetchDataVPjlnObatTotal(tgl);
    data2.then((value2) {
      if (value2.toString().contains('success')) {
        Map json = jsonDecode(value2);
        for (var i in json['data']) {
          AkuntanVPenjualanNotaObatTotal ttl =
              AkuntanVPenjualanNotaObatTotal.fromJson(i);
          TextTotalPenjualanObat = ttl.text_total_pejualan;
          // print(
          //     ' value baca data penjualan obat TextTotalPenjualanObat $TextTotalPenjualanObat');
          // fetchPenjualan.totalPenjualan = ttl.text_total_pejualan;

          // //print('fetchDataVPjlnObatTotal ${fetchPenjualan.totalPenjualan}');
        }
      } else {
        TextTotalPenjualanObat = 0;
      }

      setState(() {
        widgetTextTotalPenjualanObat();
        // globalLabaRugi.widgetListView();
        // print(
        //     'globalLabaRugi.controllerdateLR ${globalLabaRugi.controllerdateLR}');
      });
    });
    // print('AkuntanBacaDataPenjualanObat');
  }

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
                      leading: Text(
                          'Rp ${numberFormatRp.format(listPjlnTglObats[index].totalHarga)}'),
                      title: Center(
                        child: Text(
                            '${listPjlnTglObats[index].tgl_transaksi.substring(0, 10)} '),
                      ),
                      trailing: Text(
                          'Jumlah Nota: ${listPjlnTglObats[index].total_nota}'),
                    ),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          Text('Penjualan Obat null'),
        ],
      );
    }
  }

  Widget WidgetDaftarNota() {
    return Text('${listNotaPjnlObat[0].nota_id}');
  }

  Widget widgetTextTotalPenjualanObat() {
    if (TextTotalPenjualanObat != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text('Total Penjualan Obat Rp ' +
                '${numberFormatRp.format(TextTotalPenjualanObat)}')),
      );
    } else {
      return Container();
    }
  }

  var TextTotalPenjualanObat = null;

  @override
  void initState() {
    // print('set state pjln obat ${widget.tgl_transaksi}');
    streamBacaPenjualanObat();
    // AkuntanBacaDataPenjualanObat(widget.tgl_transaksi);
    super.initState();
  }

  StreamSubscription _streamObat;
  streamBacaPenjualanObat() {
    // print('streamBacaPenjualanObat');
    _streamObat = widget.stream.listen((tgl_stream) {
      AkuntanBacaDataPenjualanObat(tgl_stream);
    });
  }

  @override
  void dispose() {
    _streamObat.cancel();
    // print('cancelstream');
    super.dispose();
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
