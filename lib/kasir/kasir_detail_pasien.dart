// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/kasir/fetch_data/kasir_send_nota_penjualan.dart';
import 'package:flutter_application_1/kasir/kasir_mengurangi_stok_obat.dart';
import 'package:flutter_application_1/kasir/kasir_widget_krjg_resep.dart';
import 'package:flutter_application_1/main.dart';
import 'package:intl/intl.dart';

import 'fetch_data/kasir_get_resep.dart';
import 'fetch_data/kasir_get_tindakan.dart';

var numberFormatRpResep, numberFormatRpTindakan;
var cekInitState = 1;

double totalBiayaObat = 0;
var hargaKaliObat = [];
TextEditingController controllerBiayaAdmin = TextEditingController(text: "0");
TextEditingController controllerBiayaJasaMedis =
    TextEditingController(text: "0");
var totalMedis, totalTdknRspAdmMdis;
var totalAdmin = 0;

int totalBiayaTindakan = 0;
var refreshTextTotalPembayaran = false;
Widget widgetTextTotalPembayaran() {
  numberFormatRpResep = new NumberFormat("#,##0", "id_ID");
  print('widgetTextTotalPembayaran: $totalBiayaObat');
  if (refreshTextTotalPembayaran == true) {
    if (controllerBiayaAdmin.text.isNotEmpty) {
      totalAdmin = int.parse(controllerBiayaAdmin.text);
    }
    if (controllerBiayaJasaMedis.text.isNotEmpty) {
      totalMedis = int.parse(controllerBiayaJasaMedis.text);
    }
    totalTdknRspAdmMdis =
        totalBiayaTindakan + totalBiayaObat + totalAdmin + totalMedis;
    if (totalAdmin != null && totalMedis != null) {
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
  } else {
    return Text('Total Pembayaran');
  }
}

// ignore: must_be_immutable
class KasirDetailPasien extends StatefulWidget {
  var visitId, namaPasien, visitDate;
  bool isPasien;
  KasirDetailPasien(
      {Key key, this.visitId, this.namaPasien, this.visitDate, this.isPasien})
      : super(key: key);

  @override
  _KasirDetailPasienState createState() => _KasirDetailPasienState();
}

class _KasirDetailPasienState extends State<KasirDetailPasien> {
  @override
  void initState() {
    getUserId();
    print('init state $cekInitState');
    kasirBacaDataVListTindakan(widget.visitId);
    KasirBacaDataVResep(widget.visitId);
    super.initState();
  }

  // ignore: non_constant_identifier_names
  KasirBacaDataVResep(pVisitId) {
    kVKRs.clear();
    Future<String> data = fetchDataKasirVKeranjangResep(pVisitId);
    data.then((value) {
      numberFormatRpResep = new NumberFormat("#,##0", "id_ID");
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json.toString().contains('success'))
        for (var i in json['data']) {
          print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
          KasirVKeranjangResep kvt = KasirVKeranjangResep.fromJson(i);
          kVKRs.add(kvt);
        }
      setState(() {
        widgetKeranjangResep();
        // WidgetKrjgRsp();
        // print('set state KasirBacaDataVResep');
        // print('KasirBacaDataVResep totalBiayaObat: $totalBiayaObat');
      });
    });
  }

  kasirBacaDataVListTindakan(pVisitId) {
    kVKTs.clear();
    Future<String> data = fetchDataKasirVKeranjangTindakan(pVisitId);
    data.then((value) {
      numberFormatRpTindakan = new NumberFormat("#,##0", "id_ID");
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json.toString().contains('success'))
        for (var i in json['data']) {
          // print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
          KasirVKeranjangTindakan kvt = KasirVKeranjangTindakan.fromJson(i);
          kVKTs.add(kvt);
        }
      setState(() {
        widgetKeranjangTindakan();
      });
    });
  }

  Widget widgetKeranjangResep() {
    hargaKaliObat.clear();
    totalBiayaObat = 0;
    if (kVKRs.length > 0) {
      for (var i = 0; i < kVKRs.length; i++) {
        hargaKaliObat.add(
            double.parse(kVKRs[i].hargaJual) * double.parse(kVKRs[i].jumlah));
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
                          '${numberFormatRpResep.format(double.parse(kVKRs[index].hargaJual))}',
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

  Widget widgetInputPembayaran() {
    return Column(
      children: [
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
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
      ],
    );
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

  Widget widgetBayarYa() {
    print('kVKRs.length ${kVKRs.length}');
    return ElevatedButton(
        onPressed: () {
          if (kVKRs.length > 0 && totalTdknRspAdmMdis > 0) {
            fetchDataKasirInputNotaJual(
                    userIdMainDart,
                    widget.visitId,
                    widget.visitDate,
                    controllerBiayaJasaMedis.text,
                    controllerBiayaAdmin.text,
                    totalTdknRspAdmMdis,
                    kVKRs[0].resepId)
                .then((value) {
              if (value.contains('success')) {
                showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'pembayaran sukses',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            bayarButton = false;
                            setState(() {
                              widgetTextTotalPembayaran();
                              widgetButtonBayar();
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('ok')),
                    ],
                  ),
                );
              }
              CalculateStokObatBaru();
            });
          }
          if (kVKRs.length <= 0) {
            fetchDataKasirInputNotaJual(
                    userIdMainDart,
                    widget.visitId,
                    widget.visitDate,
                    controllerBiayaJasaMedis.text,
                    controllerBiayaAdmin.text,
                    totalTdknRspAdmMdis,
                    'null')
                .then((value) {
              print('value input nota kasir $value');
              if (value.contains('success')) {
                showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'pembayaran sukses',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            bayarButton = false;
                            setState(() {
                              widgetTextTotalPembayaran();
                              widgetButtonBayar();
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('ok')),
                    ],
                  ),
                );
              }
              CalculateStokObatBaru();
            });
          }
        },
        child: Text('Ya'));
  }

  var bayarButton = true;
  // ignore: missing_return
  Widget widgetButtonBayar() {
    // print('bayar $bayarButton');
    if (bayarButton == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // print('kVKRs[0].resepId ${kVKRs[0].resepId}');
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  'Apakah anda akan menyimpan pembayaran?',
                  style: TextStyle(fontSize: 14),
                ),
                actions: <Widget>[
                  widgetBayarYa(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('batal'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  )
                ],
              ),
            );
          },
          child: Text('Bayar'),
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              minimumSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.01)),
        ),
      );
    } else {
      Navigator.pop(context);
    }
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
                        if (widget.namaPasien != null)
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.namaPasien}',
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
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widgetInputPembayaran()),
                        if (widget.isPasien == false) widgetButtonBayar()
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
