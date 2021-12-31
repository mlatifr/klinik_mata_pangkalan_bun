import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/fetch_tindakan.dart';
import 'package:intl/intl.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetDetailNotaTindakan extends StatefulWidget {
  var nota_id;
  WidgetDetailNotaTindakan({Key key, this.nota_id}) : super(key: key);

  @override
  _WidgetDetailNotaTindakanState createState() =>
      _WidgetDetailNotaTindakanState();
}

class _WidgetDetailNotaTindakanState extends State<WidgetDetailNotaTindakan> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkuntanBacaDataDetailNotaHpp(nota_id) {
    listDetailNotaTindakan.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVListDetailNotaTindakan(nota_id);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        DetailNotaTindakan detailNotaHPP = DetailNotaTindakan.fromJson(i);
        listDetailNotaTindakan.add(detailNotaHPP);
      }
      setState(() {
        widgetTable();
      });
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

  @override
  void initState() {
    AkuntanBacaDataDetailNotaHpp(widget.nota_id);
    super.initState();
  }

  Widget widgetTable() {
    if (listDetailNotaTindakan.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Table(
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Text(
                      'Nama',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'mt_sisi',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Harga',
                      textAlign: TextAlign.center,
                    ),
                    // Text(
                    //   'Total',
                    //   textAlign: TextAlign.center,
                    // ),
                  ]),
                ]),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listDetailNotaTindakan.length,
                itemBuilder: (context, index) {
                  return Table(
                      border: TableBorder
                          .all(), // Allows to add a border decoration around your table
                      children: [
                        TableRow(children: [
                          Text(
                            '${listDetailNotaTindakan[index].nama}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${listDetailNotaTindakan[index].mt_sisi}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${numberFormatRp.format((listDetailNotaTindakan[index].harga_beli))}',
                            // '${numberFormatRp.format(int.parse(listDetailNotaPjnlObat[index].harga_jual))}',
                            textAlign: TextAlign.center,
                          ),
                          // Text(
                          //   '${numberFormatRp.format(listDetailNotaTindakan[index].total_harga)}',
                          //   // '${numberFormatRp.format(listDetailNotaPjnlObat[index].total_harga)}',
                          //   textAlign: TextAlign.center,
                          // ),
                        ]),
                      ]);
                }),
          ],
        ),
      );
    } else {
      return ListTile(title: Text('Detail Nota'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Center(
              child: Text(
                "Detail Nota Obat :${widget.nota_id}",
                maxLines: 2,
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: widgetTable()),
    );
  }
}
