import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../akuntan_fetch_penjualan_nota.dart';
import 'akuntan_fetch_penjualan_obat.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetDetailNotaObat extends StatefulWidget {
  var nota_id;
  WidgetDetailNotaObat({Key key, this.nota_id}) : super(key: key);

  @override
  _WidgetDetailNotaObatState createState() => _WidgetDetailNotaObatState();
}

class _WidgetDetailNotaObatState extends State<WidgetDetailNotaObat> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObatDetail(nota_id) {
    listDetailNotaPjnlObat.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVPjlnDetailNota(nota_id);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVDetailNotaObat pjlnObtNota = AkuntanVDetailNotaObat.fromJson(i);
        listDetailNotaPjnlObat.add(pjlnObtNota);
      }
      setState(() {});
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

  @override
  void initState() {
    AkunanBacaDataPenjualanObatDetail(widget.nota_id);
    super.initState();
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
          body: Padding(
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
                          'Jumlah',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Harga',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Total',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ]),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listDetailNotaPjnlObat.length,
                    itemBuilder: (context, index) {
                      return Table(
                          border: TableBorder
                              .all(), // Allows to add a border decoration around your table
                          children: [
                            TableRow(children: [
                              Text(
                                '${listDetailNotaPjnlObat[index].nama}',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${listDetailNotaPjnlObat[index].jumlah_terjual}',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${numberFormatRp.format(int.parse(listDetailNotaPjnlObat[index].harga_jual))}',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${numberFormatRp.format(listDetailNotaPjnlObat[index].total_harga)}',
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ]);
                    }),
              ],
            ),
          )),
    );
  }
}
