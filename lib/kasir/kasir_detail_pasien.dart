import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/kasir/kasir_get_tindakan.dart';
import 'package:flutter_application_1/main.dart';
import 'kasir_get_resep.dart';
import 'package:intl/intl.dart';

import 'kasir_send_nota_penjualan.dart';

var numberFormatRpResep, numberFormatRpTindakan;
var cekInitState = 1;

class KasirDetailPasien extends StatefulWidget {
  var visitId, namaPasien, visitDate;
  KasirDetailPasien({Key key, this.visitId, this.namaPasien, this.visitDate})
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

  int totalBiayaObat = 0;
  var hargaKaliObat = [];
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
        children: [Text('Keranjang Tindakan: '), CircularProgressIndicator()],
      );
    }
  }

  TextEditingController controllerBiayaAdmin = TextEditingController(text: "0");
  TextEditingController controllerBiayaJasaMedis =
      TextEditingController(text: "0");
  var totalMedis, totalTdknRspAdmMdis;
  var totalAdmin = 0;
  Widget widgetTextTotalPembayaran() {
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

  Widget widgetInputPembayaran() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerBiayaAdmin,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  // controllerBiayaAdmin.text = value.toString();
                  // controllerBiayaAdmin.selection = TextSelection.fromPosition(
                  //     TextPosition(offset: controllerBiayaAdmin.text.length));
                  widgetTextTotalPembayaran();
                });
              },
              decoration: InputDecoration(
                labelText: "Biaya Admin",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerBiayaJasaMedis,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  // controllerBiayaJasaMedis.text = value.toString();
                  // controllerBiayaJasaMedis.selection =
                  //     TextSelection.fromPosition(TextPosition(
                  //         offset: controllerBiayaJasaMedis.text.length));
                  widgetTextTotalPembayaran();
                });
              },
              decoration: InputDecoration(
                labelText: "Biaya Jasa Medis",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
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

  int totalBiayaTindakan = 0;
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
                                children: [widgetKeranjangResep()])),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widgetInputPembayaran()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              fetchDataKasirInputNotaJual(
                                      useridMainDart,
                                      widget.visitId,
                                      widget.visitDate,
                                      controllerBiayaJasaMedis.text,
                                      controllerBiayaAdmin.text,
                                      totalTdknRspAdmMdis)
                                  .then((value) => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                            '{$value}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widgetTextTotalPembayaran();
                                                  });
                                                  Navigator.pop(
                                                    context,
                                                    'ok',
                                                  );
                                                },
                                                child: Text('ok')),
                                          ],
                                        ),
                                      ));
                            },
                            child: Text('Bayar'),
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.01)),
                          ),
                        ),
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
