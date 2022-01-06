import 'dart:async';
import 'package:flutter_application_1/akuntan/neraca/kas/akuntan_page_akun_kas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'sediaan_barang/akuntan_page_akun_sediaan_brg.dart';

class AkuntanVNeraca extends StatefulWidget {
  const AkuntanVNeraca({Key key}) : super(key: key);

  @override
  _AkuntanVNeracaState createState() => _AkuntanVNeracaState();
}

class _AkuntanVNeracaState extends State<AkuntanVNeraca> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

// //baca data nota akun jasmed
// // ignore: non_constant_identifier_names
//   AkunanBacaDataPenjualanAdmin(tgl) {
//     listPenjualanAdmins.clear();
//     Future<String> data = fetchDataVPenjualanAdmin(tgl);
//     data.then((value) {
//       //Mengubah json menjadi Array
//       // ignore: unused_local_variable
//       Map json = jsonDecode(value);
//       for (var i in json['data']) {
//         //print(i);
//         AkuntanVPenjualanAdmin pjlnAdminNota =
//             AkuntanVPenjualanAdmin.fromJson(i);
//         listPenjualanAdmins.add(pjlnAdminNota);
//       }
//       setState(() {
//         WidgetAkunJasmed();
//       });
//     });
//   }

// //baca data nota akun jasmed
// // ignore: non_constant_identifier_names
//   AkunanBacaDataPenjualanjasmed(tgl) {
//     listPenjualanJasmeds.clear();
//     Future<String> data = fetchDataVPenjualanJasmed(tgl);
//     data.then((value) {
//       //Mengubah json menjadi Array
//       // ignore: unused_local_variable
//       Map json = jsonDecode(value);
//       for (var i in json['data']) {
//         //print(i);
//         AkuntanVPenjualanJasmed pjlnJsmdNota =
//             AkuntanVPenjualanJasmed.fromJson(i);
//         listPenjualanJasmeds.add(pjlnJsmdNota);
//       }
//       setState(() {
//         WidgetAkunJasmed();
//       });
//     });
//   }

// //baca data nota akun obat
// // ignore: non_constant_identifier_names
//   AkunanBacaDataPenjualanObat(tgl) {
//     listPenjualanObats.clear();
//     // print('listPenjualanObats: ${listPenjualanObats.length}');
//     Future<String> data = fetchDataVPenjualanObat(tgl);
//     data.then((value) {
//       //Mengubah json menjadi Array
//       // ignore: unused_local_variable
//       Map json = jsonDecode(value);
//       for (var i in json['data']) {
//         //print(i);
//         AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
//         listPenjualanObats.add(pjlnObtNota);
//       }
//       setState(() {
//         WidgetAkunObat();
//       });
//     });
//   }

// //baca data nota akun obat
// // ignore: non_constant_identifier_names
//   AkunanBacaDataHPPObat(tgl) {
//     listHppObats.clear();
//     // print('listHppObats: ${listHppObats.length}');
//     Future<String> data = fetchDataVHppObat(tgl);
//     data.then((value) {
//       //Mengubah json menjadi Array
//       // ignore: unused_local_variable
//       Map json = jsonDecode(value);
//       for (var i in json['data']) {
//         //print(i);
//         AkuntanVHppObat pjlnObtNota = AkuntanVHppObat.fromJson(i);
//         listHppObats.add(pjlnObtNota);
//       }
//       setState(() {
//         WidgetAkunHPPObat();
//       });
//     });
//   }

  var controllerdate = TextEditingController();
  Widget widgetSelectTgl() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: controllerdate,
              onChanged: (value) {
                setState(() {
                  // controllerdate.text = value.toString();
                  // controllerdate.selection = TextSelection.fromPosition(
                  //     TextPosition(offset: controllerdate.text.length));
                  // //print('TextFormField controllerdate $value');
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Bulan Transaksi',
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 7);
                      _controllerTglStream.add(controllerdate.text);
                    });
                  });
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.white,
                  size: 24.0,
                ))
          ],
        ));
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    //print(date);
    controllerdate.text = date.toString().substring(0, 7);
    _controllerTglStream.add(controllerdate.text);
    super.initState();
  }

  StreamController<String> _controllerTglStream =
      StreamController<String>.broadcast();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Neraca"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: [
              widgetSelectTgl(),
              ListTile(
                title: Text('Aset Lancar'),
              ),
              WidgetAkunKas(
                stream: _controllerTglStream.stream,
              ),
              Divider(),
              WidgetAkunSediaanBarang(
                stream: _controllerTglStream.stream,
              ),
              ListTile(
                title: Text('Total Aset Lancar: null'),
              ),
            ],
          )),
    );
  }
}
