import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/akuntan_list_nota_tindakan.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/fetch_tindakan.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class widgetListTglTindakan extends StatefulWidget {
  final Stream<String> stream;
  widgetListTglTindakan({Key key, this.stream}) : super(key: key);

  @override
  _widgetListTglTindakanState createState() => _widgetListTglTindakanState();
}

class _widgetListTglTindakanState extends State<widgetListTglTindakan> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  var TextTindakanTotal = 0;
  Widget widgetListTindakan() {
    // totalHPPObat = 0;
    if (listTglTindakan.length > 0) {
      return Column(
        children: [
          ExpansionTile(title: Text('Tindakan'), children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listTglTindakan.length,
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
                                builder: (context) => WidgetListNotaTindakan(
                                      tgl_transaksi: listTglTindakan[index]
                                          .tgl_transaksi
                                          .toString()
                                          .substring(0, 10),
                                    )));
                          },
                          title: Center(
                              child: Text(
                                  '${listTglTindakan[index].tgl_transaksi.toString().substring(0, 10)} ' +
                                      ' | Rp ${numberFormatRp.format(int.parse(listTglTindakan[index].harga))}')),
                        ),
                      ));
                }),
          ]),
        ],
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          Text('Total Tindakan null'),
        ],
      );
    }
  }

// ignore: non_constant_identifier_names
  AkunanBacaDataTindakan(tgl) {
    // print('tgl $tgl');
    listTglTindakan.clear();
    // //print('listHppObats: ${listHppObats.length}');
    Future<String> data = fetchDataVListTglTindakan(tgl);
    data.then((value) {
      if (value.toString().contains('null')) {
        listTglTindakan.clear();
      } else {
        //Mengubah json menjadi Array
        // ignore: unused_local_variable
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          // print(i);
          ListTglTindakan pjlnObtNota = ListTglTindakan.fromJson(i);
          listTglTindakan.add(pjlnObtNota);
        }
      }
      setState(() {
        // print('listHppObats[0].tgl_transaksi ${listHppObats[0].tgl_resep}');
        widgetListTindakan();
      });
    });
    fetchDataVTotalTindakan(tgl).then((value) {
      if (value.toString().contains('null')) {
        TextTindakanTotal = 0;
      } else {
        //Mengubah json menjadi Array
        // ignore: unused_local_variable
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          AkuntanVTotalTindakan tdkn = AkuntanVTotalTindakan.fromJson(i);
          TextTindakanTotal = int.parse(tdkn.total_tindakan);
          // print('TextTindakanTotal $TextTindakanTotal');
        }
      }
      setState(() {
        widgetTextTotalTindakan();
      });
    });
  }

  // ignore: unused_field
  StreamSubscription _streamTindakan;
  streamBacaHppObat() {
    _streamTindakan = widget.stream.listen((tgl_stream) {
      AkunanBacaDataTindakan(tgl_stream);
    });
  }

  @override
  void initState() {
    streamBacaHppObat();
    super.initState();
  }

  Widget widgetTextTotalTindakan() {
    if (TextTindakanTotal != 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total tindakan Rp ${numberFormatRp.format(TextTindakanTotal)}')),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Total Tindakan null'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListTindakan(),
        widgetTextTotalTindakan(),
      ],
    );
  }
}
