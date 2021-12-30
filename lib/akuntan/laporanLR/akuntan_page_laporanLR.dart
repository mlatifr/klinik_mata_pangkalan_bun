// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/akuntan_page_akun_HPP_obat.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/akuntan_page_akun_HPP_obat.dart'
    as akunHPPObat;
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_admin.dart'
    as akunAdmin;
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_jasmed.dart'
    as akunJasmed;
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_page_akun_obat.dart';
import 'package:flutter_application_1/akuntan/laporanLR/penjualan_obat/akuntan_page_akun_obat.dart'
    as akunObat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart'
    as fetchPenjualan;
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualan_nota.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_tindakan.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_tindakan.dart'
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

class _AkuntanVLaporanLRState extends State<AkuntanVLaporanLR> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

//baca data nota akun tindakan
// ignore: non_constant_identifier_names
  AkunanBacaDataListNota(tgl) {
    //print('listPenjualanTindakans before: ${listPenjualanTindakans.length}');
    if (listPenjualanTindakans.isNotEmpty) {
      listPenjualanTindakans.clear();
    }
    //print('listPenjualanTindakans after: ${listPenjualanTindakans.length}');
    Future<String> data = fetchDataVNotaPenjualan(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVNotaPenjualan pjlnTdkn = AkuntanVNotaPenjualan.fromJson(i);
        listNotaPenjualans.add(pjlnTdkn);
      }
      setState(() {
        WidgetListNota(
          listParameter: listNotaPenjualans,
          textHeaderListNota: 'Daftar Nota',
        );
      });
    });
  }

  //baca data nota akun tindakan

// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanTindakan(tgl) {
    //print('listPenjualanTindakans before: ${listPenjualanTindakans.length}');
    if (listPenjualanTindakans.isNotEmpty) {
      listPenjualanTindakans.clear();
    }
    //print('listPenjualanTindakans after: ${listPenjualanTindakans.length}');
    Future<String> data = fetchDataVPenjualanTindakan(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVPenjualanTindakan pjlnTdkn =
            AkuntanVPenjualanTindakan.fromJson(i);
        listPenjualanTindakans.add(pjlnTdkn);
      }
      setState(() {
        WidgetAkunTindakan();
      });
    });
  }

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
//         ////print(i);
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
//         AkuntanVPenjualanJasmed pjlnJsmdNota =
//             AkuntanVPenjualanJasmed.fromJson(i);
//         listPenjualanJasmeds.add(pjlnJsmdNota);
//       }
//       setState(() {
//         WidgetAkunJasmed();
//       });
//     });
//   }

//baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    listPjlnTglObats.clear();
    // //print('listPenjualanObats: ${listPenjualanObats.length}');
    //harus ada resep apoteker id di kasir
    Future<String> data = fetchDataVPjlnTglObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ////print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        listPjlnTglObats.add(pjlnObtNota);
      }
      setState(() {
        WidgetTglPnjlnObat();
      });
    }).then((value) {
      Future<String> data2 = fetchDataVPjlnObatTotal(tgl);
      data2.then((value2) {
        Map json = jsonDecode(value2);
        for (var i in json['data']) {
          AkuntanVPenjualanNotaObatTotal ttl =
              AkuntanVPenjualanNotaObatTotal.fromJson(i);
          fetchPenjualan.totalPenjualan = ttl.text_total_pejualan;

          // //print('fetchDataVPjlnObatTotal ${fetchPenjualan.totalPenjualan}');
        }

        setState(() {
          WidgetTglPnjlnObat();
        });
      });
    });
  }

//baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataHPPObat(tgl) {
    listHppObats.clear();
    // //print('listHppObats: ${listHppObats.length}');
    Future<String> data = fetchDataVHppObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ////print(i);
        AkuntanVHppObat pjlnObtNota = AkuntanVHppObat.fromJson(i);
        listHppObats.add(pjlnObtNota);
      }
      setState(() {
        WidgetAkunHPPObat();
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
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 7);
                      // baca data seluruh nota transaksi yg ada di klinik
                      AkunanBacaDataPenjualanObat(controllerdate.text);
                      // AkunanBacaDataPenjualanjasmed(controllerdate.text);
                      // AkunanBacaDataPenjualanAdmin(controllerdate.text);
                      AkunanBacaDataHPPObat(controllerdate.text);
                      AkunanBacaDataPenjualanTindakan(controllerdate.text);
                      AkunanBacaDataListNota(controllerdate.text);
                      ////print('showDatePicker : ${controllerdate.text}');
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
    ////print(date);
    controllerdate.text = date.toString().substring(0, 7);
    AkunanBacaDataPenjualanObat(controllerdate.text);
    AkunanBacaDataHPPObat(controllerdate.text);
    AkunanBacaDataPenjualanTindakan(controllerdate.text);
    AkunanBacaDataListNota(controllerdate.text);

    // AkunanBacaDataPenjualanjasmed(controllerdate.text);
    // AkunanBacaDataPenjualanAdmin(controllerdate.text);

    super.initState();
  }

  // Widget WidgetLabaBersih() {
  //   return ListTile(
  //     title: Text(
  //         "Laba Bersih: ${fetchPenjualan.totalPenjualan - akunHPPObat.totalHPPObat + akunTindakanOperasi.totalTindakanOperasi - akunJasmed.totalBiayaKomisiJasmed - akunAdmin.totalKomisiAdmin} \n"),
  //   );
  // }

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
          body: ListView(
            children: [
              widgetSelectTgl(),
              WidgetTglPnjlnObat(
                  textHeaderPenjualanObat: 'Penjualan Obat',
                  totalPenjualan: fetchPenjualan.totalPenjualan),

              WidgetAkunHPPObat(tgl_hpp: controllerdate.text),
              Divider(),
              WidgetLabaKotor(tgl_laba_kotor: controllerdate.text),
              Divider(),
              WidgetAkunTindakan(
                pTextDaftarPenjualanTindakna: 'Pendapatan Tindakan Operasi',
              ),
              Divider(),
              // Text("Pendapatan: ${listPenjualanTindakans.length}"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // WidgetLabaBersih();
                      });
                    },
                    child: Text('Laba Bersih')),
              ),
              // WidgetLabaBersih()
            ],
          )),
    );
  }
}
