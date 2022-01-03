// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/akuntan_page_akun_HPP_obat.dart'
    as akunHPPObat;
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_widget_penjualan_obat.dart'
    as akunObat;

import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart'
    as fetchPenjualan;

import 'fetch_laba_kotor.dart';

class WidgetLabaKotor extends StatefulWidget {
  var tgl_laba_kotor;
  final Stream<String> stream;
  WidgetLabaKotor({Key key, this.tgl_laba_kotor, this.stream})
      : super(key: key);

  @override
  _WidgetLabaKotorState createState() => _WidgetLabaKotorState();
}

class _WidgetLabaKotorState extends State<WidgetLabaKotor> {
  int labaKotor = 0;
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetTextLabarKotor() {
    if (labaKotor == 0) {
      return Text('labaKotor null');
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text('Laba Kotor: Rp ${numberFormatRp.format(labaKotor)}')),
      );
    }
  }

  StreamSubscription _streamLabaKotor;
  streamBacaHppObat() {
    _streamLabaKotor = widget.stream.listen((tgl_stream) {
      fetchDataVLabaKotor(tgl_stream).then((value) {
        //Mengubah json menjadi Array
        // ignore: unused_local_variable
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          print('i laba kotor $i');
          AkuntanVLabaKotor lbKotor = AkuntanVLabaKotor.fromJson(i);
          // print(lbKotor.laba_kotor.runtimeType);
          labaKotor = lbKotor.laba_kotor;
        }
        setState(() {
          widgetTextLabarKotor();
        });
      });
    });
  }

  @override
  void initState() {
    streamBacaHppObat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetTextLabarKotor(),
      ],
    );
  }
}
