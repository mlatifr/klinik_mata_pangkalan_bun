import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/views/v_CoA.dart';
import 'package:flutter_application_1/akuntan/laporanLR/akuntan_page_laporanLR.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/views/akuntan_page_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_page_split_view.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/views/vList_penjurnalan.dart';
import '../main.dart';
import 'neraca/akuntan_page_neraca.dart';
import 'neraca_percobaan/view/neraca_percobaan_v.dart';
import 'nota/nota_obat/view/nota_obat_v.dart';
import 'nota/nota_tindakan/view/nota_tindakan_v.dart';
import 'page_input_penjurnalan/services/akuntan_get_daftar_akun.dart';

class AkuntanMainPage extends StatefulWidget {
  const AkuntanMainPage({Key key}) : super(key: key);

  @override
  _AkuntanMainPageState createState() => _AkuntanMainPageState();
}

class _AkuntanMainPageState extends State<AkuntanMainPage> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n ' + username,
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.85),
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('./asset/image/clinic_text.jpg'),
              ),
            ),
          ),
          ListTile(
            title: Text('Chart Of Account'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChartOfAccount()));
            },
          ),
          ListTile(
            title: Text('Daftar Penjurnalan'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListPenjurnalan()));
            },
          ),
          ListTile(
            title: Text('Nota Obat'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AkuntanViewNotaObat()));
            },
          ),
          ListTile(
            title: Text('Nota Tindakan'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AkuntanViewNotaTindakan()));
            },
          ),
          ListTile(
            title: Text('Neraca'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NeracaPercobaanView()));
            },
          ),
          // ListTile(
          //   title: Text('Neraca'),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AkuntanVNeraca()));
          //   },
          // ),
          ListTile(
            title: Text('Laporan Laba Rugi'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AkuntanVLaporanLR()));
            },
          ),
          // ListTile(
          //   title: Text('Daftar Nota Penjualan'),
          //   onTap: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
          //   },
          // ),

          // ListTile(
          //   title: Text('Input Penjurnalan'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AkuntanInputPenjurnalan()));
          //   },
          // ),
          ListTile(
            title: Text('Split View'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerticalSplitView(
                            window1: AkuntanVLaporanLR(),
                            window2: AkuntanInputPenjurnalan(),
                          )));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Navigator.pop(context);
              // _timerForInter.cancel();
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    fetchDataAkuntanVDftrAkun().then((value) {
      akntVDftrAkns.clear();
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        AkuntanVDftrAkun dvlt = AkuntanVDftrAkun.fromJson(i);
        akntVDftrAkns.add(dvlt);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Halaman Utama"),
          ),
          drawer: widgetDrawer(),
          body: Column(
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       fetchDataAkuntanInputTransaksiPenjurnalanArray();
              //     },
              //     child: Text('From Postman'))
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
