import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_page_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_nota_penjualan.dart';
import 'package:flutter_application_1/akuntan/akuntan_page_split_view.dart';
import 'package:flutter_application_1/pemilik/input_order/pemilik_page_input_order.dart';
import '../main.dart';

class PemilikMainPage extends StatefulWidget {
  const PemilikMainPage({Key key}) : super(key: key);

  @override
  _PemilikMainPageState createState() => _PemilikMainPageState();
}

class _PemilikMainPageState extends State<PemilikMainPage> {
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
          // ListTile(
          //   title: Text('Daftar Nota Penjualan'),
          //   onTap: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
          //   },
          // ),
          ListTile(
            title: Text('Input Order'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PemilikInputOrderObat(pmlkId: userIdMainDart)));
            },
          ),
          ListTile(
            title: Text('Split View'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerticalSplitView(
                            window1: AkuntanVNotaPjln(),
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
    getUserId();
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
