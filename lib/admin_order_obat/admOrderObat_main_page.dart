import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_order_obat/input_order/admOrderObat_page_input_order.dart';
import '../main.dart';

class AdmOrderObatMainPage extends StatefulWidget {
  const AdmOrderObatMainPage({Key key}) : super(key: key);

  @override
  _AdmOrderObatMainPageState createState() => _AdmOrderObatMainPageState();
}

class _AdmOrderObatMainPageState extends State<AdmOrderObatMainPage> {
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
            title: Text('Konfirmasi Order'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminOrderInputKonfirmasiObat(
                          adminId: userIdMainDart)));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
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
            children: [],
          )),
    );
  }
}
