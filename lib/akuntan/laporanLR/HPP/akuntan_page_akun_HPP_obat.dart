import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/fetch_hpp_obat.dart';
import 'package:intl/intl.dart';

import 'akuntan_list_nota_hpp.dart';

// int totalHPPObat = 0;

// ignore: must_be_immutable
class WidgetAkunHPPObat extends StatefulWidget {
  final Stream<String> stream;
  WidgetAkunHPPObat({Key key, this.stream}) : super(key: key);

  @override
  _WidgetAkunHPPObatState createState() => _WidgetAkunHPPObatState();
}

class _WidgetAkunHPPObatState extends State<WidgetAkunHPPObat> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  var TextHppObat = 0;
  Widget widgetListHPPObat() {
    // totalHPPObat = 0;
    if (listHppObats.length > 0) {
      return Column(
        children: [
          ExpansionTile(title: Text('Penjualan HPP obat'), children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listHppObats.length,
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WidgetListNotaHpp(
                                      tgl_transaksi: listHppObats[index]
                                          .tgl_transaksi
                                          .toString()
                                          .substring(0, 10),
                                    )));
                          },
                          leading: Text(
                              'Rp ${numberFormatRp.format(listHppObats[index].total_harga)}'),
                          title: Center(
                            child: Text(
                                '${listHppObats[index].tgl_transaksi.toString().substring(0, 10)}'),
                          ),
                          trailing: Text(
                              'Jumlah Nota: ${listHppObats[index].total_nota}'),
                        ),
                      ));
                }),
          ]),
          widgetTextTotalHPPObat(),
        ],
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          Text('HPP Penjualan Obat null'),
        ],
      );
    }
  }

// ignore: non_constant_identifier_names
  AkunanBacaDataHPPObat(tgl) {
    // print('tgl $tgl');
    listHppObats.clear();
    // //print('listHppObats: ${listHppObats.length}');
    Future<String> data = fetchDataVHppObat(tgl);
    data.then((value) {
      // print('AkunanBacaDataHPPObat $value');
      if (value.toString().contains('null')) {
        listHppObats.clear();
      } else {
        //Mengubah json menjadi Array
        // ignore: unused_local_variable
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          // print('hppObatI $i');
          AkuntanVHppObat pjlnObtNota = AkuntanVHppObat.fromJson(i);
          listHppObats.add(pjlnObtNota);
        }
        setState(() {
          // print('listHppObats[0].tgl_transaksi ${listHppObats[0].tgl_resep}');
          widgetListHPPObat();
        });
      }
    });

    fetchDataVTotalHppObat(tgl).then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        AkuntanVTotalHppObat hpp = AkuntanVTotalHppObat.fromJson(i);
        TextHppObat = hpp.hpp_total;
        // print('TextHppObat $TextHppObat');
      }
      setState(() {
        widgetListHPPObat();
      });
    });
  }

  // ignore: unused_field
  StreamSubscription _streamHppObat;
  streamBacaHppObat() {
    _streamHppObat = widget.stream.listen((tgl_stream) {
      AkunanBacaDataHPPObat(tgl_stream);
    });
  }

  @override
  void dispose() {
    // _streamHppObat.cancel();
    // print('cancelstream _streamHppObat');
    super.dispose();
  }

  @override
  void initState() {
    streamBacaHppObat();
    super.initState();
  }

  Widget widgetTextTotalHPPObat() {
    if (TextHppObat != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total HPP Obat Rp ${numberFormatRp.format(TextHppObat)}')),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetListHPPObat();
  }
}
