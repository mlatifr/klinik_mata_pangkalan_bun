import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fetch_kas.dart';

int totalAkunKas = 0;

// ignore: must_be_immutable
class WidgetAkunKas extends StatefulWidget {
  final Stream<String> stream;
  WidgetAkunKas({Key key, this.stream}) : super(key: key);

  @override
  _WidgetAkunKasState createState() => _WidgetAkunKasState();
}

class _WidgetAkunKasState extends State<WidgetAkunKas> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListKas() {
    totalAkunKas = 0;
    if (listAkunKass.length > 0) {
      return ExpansionTile(title: Text('Akun Kas'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listAkunKass.length,
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
                      title: Center(
                        child: Text(
                            '${listAkunKass[index].tgl_transaksi.toString().substring(0, 10)} | ' +
                                'Rp ${numberFormatRp.format(int.parse(listAkunKass[index].totalHarga))}'),
                      ),
                    ),
                  ));
            }),
      ]);
    } else
      return Text('Akun Kas Null');
  }

  Widget widgetTextTotalKas() {
    if (listAkunKass.length > 0) {
      //print('ListPenjualanJasmed.length: ${listAkunKass.length}');
      for (var i = 0; i < listAkunKass.length; i++) {
        totalAkunKas += int.parse(listAkunKass[i].totalHarga);
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Akun Kas Rp ${numberFormatRp.format(totalAkunKas)}')),
      );
    } else
      return Container();
  }

  @override
  void initState() {
    // print('set state pjln obat ${widget.tgl_transaksi}');
    streamBacaPenjualanObat();
    // AkuntanBacaDataPenjualanObat(widget.tgl_transaksi);
    super.initState();
  }

  // ignore: unused_field
  StreamSubscription _streamKas;
  streamBacaPenjualanObat() {
    // print('streamBacaPenjualanObat');
    _streamKas = widget.stream.listen((tgl_stream) {
      AkuntanBacaDataAkunKas(tgl_stream);
    });
  }

  //baca data nota akun kas
// ignore: non_constant_identifier_names
  AkuntanBacaDataAkunKas(tgl) {
    // print('listAkunKass before: ${listAkunKass.length}');
    if (listAkunKass.isNotEmpty) {
      listAkunKass.clear();
    }
    // print('listAkunKass after: ${listAkunKass.length}');
    Future<String> data = fetchDataKas(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print(i);
        AkuntanVKas AkunKas = AkuntanVKas.fromJson(i);
        listAkunKass.add(AkunKas);
      }
      setState(() {
        widgetListKas();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListKas(),
        widgetTextTotalKas(),
      ],
    );
  }
}
