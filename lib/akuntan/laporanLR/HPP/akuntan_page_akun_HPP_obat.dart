import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/fetch_hpp_obat.dart';
import 'package:intl/intl.dart';

import 'akuntan_list_nota_hpp.dart';

// int totalHPPObat = 0;

// ignore: must_be_immutable
class WidgetAkunHPPObat extends StatefulWidget {
  var tgl_hpp;
  WidgetAkunHPPObat({Key key, this.tgl_hpp}) : super(key: key);

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
                                builder: (context) => WidgetListNotaHpp()));
                          },
                          title: Center(
                            child: Text(
                                '${listHppObats[index].tgl_transaksi.toString().substring(0, 10)}' +
                                    ' | Rp ${numberFormatRp.format(listHppObats[index].totalHarga)}'),
                          ),
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
          Text('HPP Penjualan Obat'),
        ],
      );
    }
  }

  @override
  void initState() {
    fetchDataVTotalHppObat(widget.tgl_hpp).then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        AkuntanVTotalHppObat hpp = AkuntanVTotalHppObat.fromJson(i);
        TextHppObat = hpp.hpp_total;
        print('TextHppObat $TextHppObat');
      }
      setState(() {
        widgetTextTotalHPPObat();
      });
    });
    super.initState();
  }

  Widget widgetTextTotalHPPObat() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          title:
              Text('Total HPP Obat Rp ${numberFormatRp.format(TextHppObat)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widgetListHPPObat();
  }
}
