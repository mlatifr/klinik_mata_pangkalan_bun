import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/kasir/fetch_data/kasir_get_resep.dart';
import 'package:flutter_application_1/main.dart';
import 'package:intl/intl.dart';

import '../kasir_widget_krjg_resep.dart';

class KasirVDetailPembelianNonVisit extends StatefulWidget {
  var resep_id;
  KasirVDetailPembelianNonVisit({Key key, this.resep_id}) : super(key: key);

  @override
  _KasirVDetailPembelianNonVisitState createState() =>
      _KasirVDetailPembelianNonVisitState();
}

class _KasirVDetailPembelianNonVisitState
    extends State<KasirVDetailPembelianNonVisit> {
  @override
  void initState() {
    getUserId();
    KasirBacaDataVResepNonVisit(widget.resep_id);
    super.initState();
  }

  int totalBiayaObat = 0;
  var hargaKaliObat = [];
  var refreshTextTotalPembayaran = false;
  Widget widgetKeranjangResep() {
    hargaKaliObat.clear();
    totalBiayaObat = 0;
    if (kasir_krjg_obt_non_visit.length > 0) {
      for (var i = 0; i < kasir_krjg_obt_non_visit.length; i++) {
        hargaKaliObat
            .add(int.parse(kVKRs[i].hargaJual) * int.parse(kVKRs[i].jumlah));
        // totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
      }
      for (var i = 0; i < hargaKaliObat.length; i++) {
        // hargaKaliObat.add(KVKRs[i].hargaJual * KVKRs[i].jumlah);
        totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
        refreshTextTotalPembayaran = true;
      }
      setState(() {
        print('WidgetKrjgRsp totalBiayaObat: $totalBiayaObat');
      });
      return Column(
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
                    'Harga Satuan',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga Total',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: kasir_krjg_obt_non_visit.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          ' $index| ${kasir_krjg_obt_non_visit[index].nama_pembeli}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${kasir_krjg_obt_non_visit[index].jumlah}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpResep.format(int.parse(kasir_krjg_obt_non_visit[index].harga_jual))}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpResep.format(hargaKaliObat[index])}',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ]);
              }),
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${numberFormatRpResep.format(totalBiayaObat)}',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ],
      );
    } else {
      return Row(
        children: [Text('Keranjang Obat: '), CircularProgressIndicator()],
      );
    }
  }

  var numberFormatRpResep;
  // ignore: non_constant_identifier_names
  KasirBacaDataVResepNonVisit(resep_id) {
    kasir_krjg_obt_non_visit.clear();
    Future<String> data = fetchDataKasirVKeranjangResepNonVisit(resep_id);
    data.then((value) {
      numberFormatRpResep = new NumberFormat("#,##0", "id_ID");
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
        KasirVKrjgObatNonVisit kvt = KasirVKrjgObatNonVisit.fromJson(i);
        kasir_krjg_obt_non_visit.add(kvt);
      }
      setState(() {
        widgetKeranjangResep();
        // WidgetKrjgRsp();
        // print('set state KasirBacaDataVResep');
        // print('KasirBacaDataVResep totalBiayaObat: $totalBiayaObat');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Detail Biaya'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                                title: Text(
                                  'Resep',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                                children: [
                                  widgetKeranjangResep(),
                                  // WidgetKrjgRsp()
                                ])),
                        // Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: widgetInputPembayaran()),
                        // widgetButtonBayar()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
