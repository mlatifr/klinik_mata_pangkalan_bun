// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/akuntan_page_akun_HPP_obat.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/akuntan_page_akun_HPP_obat.dart'
    as akunHPPObat;
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/stream_test.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_admin.dart'
    as akunAdmin;
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_jasmed.dart'
    as akunJasmed;
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_widget_penjualan_obat.dart';
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_widget_penjualan_obat.dart'
    as akunObat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart'
    as fetchPenjualan;
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/akuntan_page_akun_tindakan.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/akuntan_page_akun_tindakan.dart'
    as akunTindakanOperasi;
import 'package:flutter_application_1/akuntan/page_nota/akuntan_widget_list_nota.dart';
import 'package:intl/intl.dart';
import 'HPP/fetch_hpp_obat.dart';
import 'laba_kotor/akuntan_page_laba_kotor.dart';

class AkuntanVLaporanLR extends StatefulWidget {
  const AkuntanVLaporanLR({Key key}) : super(key: key);

  @override
  _AkuntanVLaporanLRState createState() => _AkuntanVLaporanLRState();
}

_AkuntanVLaporanLRState globalLabaRugi = _AkuntanVLaporanLRState();

class _AkuntanVLaporanLRState extends State<AkuntanVLaporanLR> {
  var controllerdateLR = TextEditingController();

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetSelectTgl() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: controllerdateLR,
              onChanged: (value) {
                setState(() {});
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
                    controllerdateLR.text = value.toString().substring(0, 7);
                    // akunObat.globalBacaDataObat(controllerdateLR.text);
                    setState(() {
                      akunObat.globalObat
                          .AkuntanBacaDataPenjualanObat(controllerdateLR.text);
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
    controllerdateLR.text = date.toString().substring(0, 7);
    super.initState();
  }

  Widget widgetListView() {
    return ListView(
      children: [
        widgetSelectTgl(),
        WidgetStream(stream: _controller.stream),
        WidgetTglPnjlnObat(
          tgl_transaksi: controllerdateLR.text,
        ),
        WidgetAkunHPPObat(tgl_hpp: controllerdateLR.text),
        Divider(),
        WidgetLabaKotor(tgl_laba_kotor: controllerdateLR.text),
        Divider(),
        widgetListTglTindakan(
          tgl_nota_tindakan: controllerdateLR.text,
        ),
        Divider(),
      ],
    );
  }

  StreamController<int> _controller = StreamController<int>();

  int _seconds = 1;
  void _addPressed() {
    //somehow call _updateSeconds()
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Laporan Laba Rugi"),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: widgetListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addPressed();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
