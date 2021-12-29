import 'dart:convert';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_admin.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_jasmed.dart';
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_page_akun_obat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

class AkuntanVNotaPjln extends StatefulWidget {
  const AkuntanVNotaPjln({Key key}) : super(key: key);

  @override
  _AkuntanVNotaPjlnState createState() => _AkuntanVNotaPjlnState();
}

class _AkuntanVNotaPjlnState extends State<AkuntanVNotaPjln> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

//baca data nota akun tindakan
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanTindakan(tgl) {
    listPenjualanTindakans.clear();
    Future<String> data = fetchDataVPenjualanTindakan(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        AkuntanVPenjualanTindakan pjlnTdkn =
            AkuntanVPenjualanTindakan.fromJson(i);
        listPenjualanTindakans.add(pjlnTdkn);
      }
      setState(() {
        WidgetAkunJasmed();
      });
    });
  }

//baca data nota akun jasmed
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanAdmin(tgl) {
    listPenjualanAdmins.clear();
    Future<String> data = fetchDataVPenjualanAdmin(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print(i);
        AkuntanVPenjualanAdmin pjlnAdminNota =
            AkuntanVPenjualanAdmin.fromJson(i);
        listPenjualanAdmins.add(pjlnAdminNota);
      }
      setState(() {
        WidgetAkunJasmed();
      });
    });
  }

//baca data nota akun jasmed
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanjasmed(tgl) {
    listPenjualanJasmeds.clear();
    Future<String> data = fetchDataVPenjualanJasmed(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVPenjualanJasmed pjlnJsmdNota =
            AkuntanVPenjualanJasmed.fromJson(i);
        listPenjualanJasmeds.add(pjlnJsmdNota);
      }
      setState(() {
        WidgetAkunJasmed();
      });
    });
  }

//baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    listPjlnTglObats.clear();
    Future<String> data = fetchDataVPjlnTglObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        listPjlnTglObats.add(pjlnObtNota);
      }
      setState(() {
        WidgetTglPnjlnObat();
      });
    });
  }

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
                  // print('TextFormField controllerdate $value');
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
                      controllerdate.text = value.toString().substring(0, 10);
                      // baca data seluruh nota transaksi yg ada di klinik
                      AkunanBacaDataPenjualanObat(controllerdate.text);
                      AkunanBacaDataPenjualanjasmed(controllerdate.text);
                      AkunanBacaDataPenjualanAdmin(controllerdate.text);
                      AkunanBacaDataPenjualanTindakan(controllerdate.text);
                      print('showDatePicker : ${controllerdate.text}');
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
    print(date);
    controllerdate.text = date.toString().substring(0, 10);
    AkunanBacaDataPenjualanObat(controllerdate.text);
    AkunanBacaDataPenjualanjasmed(controllerdate.text);
    AkunanBacaDataPenjualanAdmin(controllerdate.text);
    AkunanBacaDataPenjualanTindakan(controllerdate.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Nota Penjualan"),
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
              WidgetAkunJasmed(
                pTextDaftarPenjualanJasmed: 'Penjualan jasa medis',
              ),
              Divider(),
              WidgetTglPnjlnObat(
                textHeaderPenjualanObat: 'Penjualan Obat',
              ),
              Divider(),
              WidgetAkunAdmin(
                pTextTittle: 'biaya admin',
                pTextTotal: 'total biaya admin',
              ),
            ],
          )),
    );
  }
}
