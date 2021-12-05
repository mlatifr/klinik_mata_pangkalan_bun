import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/kasir/kasir_get_resep.dart';
import 'package:flutter_application_1/kasir/kasir_get_tindakan.dart';
import 'package:flutter_application_1/pasien/pasien_fetch_visit_id.dart';
import 'package:flutter_application_1/pasien/riwayat_periksa.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class NotaPembayaranPasien extends StatefulWidget {
  var visitId;
  NotaPembayaranPasien({Key key, this.visitId}) : super(key: key);

  @override
  _NotaPembayaranPasienState createState() => _NotaPembayaranPasienState();
}

class _NotaPembayaranPasienState extends State<NotaPembayaranPasien> {
  int totalBiayaObat = 0;
  var hargaKaliObat = [];
  var numberFormatRpResep, numberFormatRpTindakan;
  TextEditingController controllerBiayaAdmin = TextEditingController(text: "0");
  TextEditingController controllerBiayaJasaMedis =
      TextEditingController(text: "0");
  var totalAdmin = 0;
  int totalBiayaTindakan = 0;
  var totalMedis, totalTdknRspAdmMdis;
  Widget widgetTextTotalPembayaran() {
    print('widgetTextTotalPembayaran: $totalBiayaObat');
    if (controllerBiayaAdmin.text.isNotEmpty) {
      totalAdmin = int.parse(controllerBiayaAdmin.text);
    }
    if (controllerBiayaJasaMedis.text.isNotEmpty) {
      totalMedis = int.parse(controllerBiayaJasaMedis.text);
    }
    totalTdknRspAdmMdis =
        totalBiayaTindakan + totalBiayaObat + totalAdmin + totalMedis;
    if (totalAdmin != 0 && totalMedis != 0) {
      return Text(
        'Rp ${numberFormatRpResep.format(totalTdknRspAdmMdis)}',
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'Rp ${totalTdknRspAdmMdis}',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget widgetKeranjangTindakan() {
    totalBiayaTindakan = 0;
    if (kVKTs.length > 0) {
      for (var i = 0; i < kVKTs.length; i++) {
        totalBiayaTindakan = totalBiayaTindakan + kVKTs[i].harga;
      }
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
                    'Tindakan',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: kVKTs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          '${kVKTs[index].nama}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${kVKTs[index].mtSisi}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpTindakan.format(kVKTs[index].harga)}',
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
                    '',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${numberFormatRpTindakan.format(totalBiayaTindakan)}',
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
        children: [Text('Keranjang Tindakan: '), CircularProgressIndicator()],
      );
    }
  }

  Widget widgetKeranjangResep() {
    hargaKaliObat.clear();
    totalBiayaObat = 0;
    if (kVKRs.length > 0) {
      for (var i = 0; i < kVKRs.length; i++) {
        hargaKaliObat
            .add(int.parse(kVKRs[i].hargaJual) * int.parse(kVKRs[i].jumlah));
        // totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
      }
      for (var i = 0; i < hargaKaliObat.length; i++) {
        // hargaKaliObat.add(KVKRs[i].hargaJual * KVKRs[i].jumlah);
        totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
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
              itemCount: kVKRs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          ' $index| ${kVKRs[index].namaObat}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${kVKRs[index].jumlah}',
                          textAlign: TextAlign.center,
                        ),
                        // Text(
                        //   '${kVKRs[index].stok}',
                        //   textAlign: TextAlign.center,
                        // ),
                        Text(
                          '${numberFormatRpResep.format(int.parse(kVKRs[index].hargaJual))}',
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

  pasienBacaDataVListTindakan(pVisitId) {
    kVKTs.clear();
    Future<String> data = fetchDataKasirVKeranjangTindakan(pVisitId);
    data.then((value) {
      numberFormatRpTindakan = new NumberFormat("#,##0", "id_ID");
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
        KasirVKeranjangTindakan kvt = KasirVKeranjangTindakan.fromJson(i);
        kVKTs.add(kvt);
      }
      setState(() {
        widgetKeranjangTindakan();
      });
    });
  }

  // ignore: non_constant_identifier_names
  pasienBacaDataVResep(pVisitId) {
    kVKRs.clear();
    Future<String> data = fetchDataDokterVKeranjangResep(pVisitId);
    data.then((value) {
      numberFormatRpResep = new NumberFormat("#,##0", "id_ID");
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
        KasirVKeranjangResep kvt = KasirVKeranjangResep.fromJson(i);
        kVKRs.add(kvt);
      }
      setState(() {
        widgetKeranjangResep();
        // WidgetKrjgRsp();
        // print('set state pasienBacaDataVResep');
        // print('pasienBacaDataVResep totalBiayaObat: $totalBiayaObat');
      });
    });
  }

  @override
  void initState() {
    getUserId();
    print('nota_pembayaran init state getUserId: $userIdMainDart ');
    pasienBacaDataVListTindakan(widget.visitId);
    pasienBacaDataVResep(widget.visitId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Nota Pembayaran Pasien'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              visitIdPasien = 0;
              print('visitIdPasien $visitIdPasien notaPembayaran back');
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
                            child: Text(
                              'visit id: ${widget.visitId}',
                              style: TextStyle(fontSize: 22),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                              title: Text(
                                'Tindakan',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              children: [
                                widgetKeranjangTindakan(),
                              ]),
                        ),
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
                        Table(
                            border: TableBorder
                                .all(), // Allows to add a border decoration around your table
                            children: [
                              TableRow(children: [
                                Text(
                                  'Total Pembayaran: ',
                                  textAlign: TextAlign.center,
                                ),
                                widgetTextTotalPembayaran(),
                              ]),
                            ]),
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
