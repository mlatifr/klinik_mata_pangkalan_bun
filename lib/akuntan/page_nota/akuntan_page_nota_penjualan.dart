import 'dart:convert';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_jasmed.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_obat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

class AkuntanVNotaPjln extends StatefulWidget {
  const AkuntanVNotaPjln({Key key}) : super(key: key);

  @override
  _AkuntanVNotaPjlnState createState() => _AkuntanVNotaPjlnState();
}

class _AkuntanVNotaPjlnState extends State<AkuntanVNotaPjln> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
//baca data nota akun jasmed
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanjasmed(tgl) {
    ListPenjualanJasmeds.clear();
    Future<String> data = fetchDataVPenjualanJasmed(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        AkuntanVPenjualanJasmed pjlnJsmdNota =
            AkuntanVPenjualanJasmed.fromJson(i);
        ListPenjualanJasmeds.add(pjlnJsmdNota);
      }
      setState(() {
        WidgetAkunJasmed();
      });
    });
  } //baca data nota akun obat

// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    ListPenjualanObats.clear();
    Future<String> data = fetchDataVPenjualanObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        ListPenjualanObats.add(pjlnObtNota);
      }
      setState(() {
        WidgetAkunObat();
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
                  controllerdate.text = value.toString();
                  controllerdate.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerdate.text.length));
                  print('TextFormField controllerdate $value');
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
              WidgetAkunObat(),
              Divider(),
              WidgetAkunJasmed(),
            ],
          )),
    );
  }
}
