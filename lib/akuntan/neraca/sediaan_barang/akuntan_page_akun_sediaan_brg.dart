import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fetch_sediaan_barang.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetAkunSediaanBarang extends StatefulWidget {
  final Stream<String> stream;
  WidgetAkunSediaanBarang({Key key, this.stream}) : super(key: key);

  @override
  _WidgetAkunSediaanBarangState createState() =>
      _WidgetAkunSediaanBarangState();
}

class _WidgetAkunSediaanBarangState extends State<WidgetAkunSediaanBarang> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListSediaanBarang() {
    totalPenjualan = 0;
    if (listAkunSediaanBrgs.length > 0) {
      return ExpansionTile(title: Text('Sediaan Barang'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listAkunSediaanBrgs.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text('${listAkunSediaanBrgs[index].namaObat}'),
                        subtitle: Text(
                            'Stok: ${listAkunSediaanBrgs[index].stok} ' +
                                '\nHarga: ${numberFormatRp.format(int.parse(listAkunSediaanBrgs[index].harga))}'
                            // +                          '\nTotal: ${numberFormatRp.format(listAkunSediaanBrgs[index].stok * int.parse(listAkunSediaanBrgs[index].harga))}'),
                            )),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
      );
    }
  }

  Widget widgetTextTotalSediaanBarang() {
    if (listAkunSediaanBrgs.length > 0) {
      //print('ListPenjualanObat.length: ${plistPenjualanObats.length}');
      //masih error disini
      for (var i = 0; i < listAkunSediaanBrgs.length; i++) {
        totalPenjualan = totalPenjualan +
            (listAkunSediaanBrgs[i].stok *
                int.parse(listAkunSediaanBrgs[i].harga));
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Obat Rp ${numberFormatRp.format(totalPenjualan)}')),
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          // Text('data tidak ditemukan'),
        ],
      );
    }
  }

  @override
  void initState() {
    // print('set state pjln obat ${widget.tgl_transaksi}');
    streamBacaKas();
    // AkuntanBacaDataPenjualanObat(widget.tgl_transaksi);
    super.initState();
  }

  // ignore: unused_field
  StreamSubscription _streamKas;
  streamBacaKas() {
    // print('streamBacaPenjualanObat');
    _streamKas = widget.stream.listen((tgl_stream) {
      AkuntanBacaDataAkunSediaanBrg(tgl_stream);
    });
  }

  //baca data nota akun sediaan barang
  // ignore: non_constant_identifier_names
  AkuntanBacaDataAkunSediaanBrg(tgl) {
    // print('listAkunSediaanBrgs before: ${listAkunSediaanBrgs.length}');
    if (listAkunSediaanBrgs.isNotEmpty) {
      listAkunSediaanBrgs.clear();
    }
    Future<String> data;

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    // print('listAkunSediaanBrgs after: ${listAkunSediaanBrgs.length}');
    print('tgl $tgl | date ${date.toString().substring(0, 7)}');
    if (tgl == date.toString().substring(0, 7)) {
      data = fetchDataSediaanBrg();
    } else {
      data = fetchDataSediaanBrgTgl(tgl);
    }
    data.then((value) {
      // print('AkuntanBacaDataAkunSediaanBrg $value');
      if (value.toString().contains('null')) {
        listAkunSediaanBrgs.clear();
      } else {
        // Mengubah json menjadi Array
        // ignore: unused_local_variable
        Map json = jsonDecode(value);
        for (var i in json['data']) {
          // print(i);
          AkuntanVSediaanBrg AkunSediaanBrg = AkuntanVSediaanBrg.fromJson(i);
          listAkunSediaanBrgs.add(AkunSediaanBrg);
        }
      }

      setState(() {
        widgetListSediaanBarang();
        widgetTextTotalSediaanBarang();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListSediaanBarang(),
        // widgetTextTotalSediaanBarang(),
      ],
    );
  }
}
