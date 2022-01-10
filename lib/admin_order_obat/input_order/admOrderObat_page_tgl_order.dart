import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';
import 'package:flutter_application_1/admin_order_obat/input_order/admOrderObat_page_nota_order.dart';

DateTime date;

class AdminOrderTglOrder extends StatefulWidget {
  final adminId, namaPasien, visitId;

  const AdminOrderTglOrder(
      {Key key, this.adminId, this.namaPasien, this.visitId})
      : super(key: key);

  @override
  _AdminOrderTglOrderState createState() => _AdminOrderTglOrderState();
}

class _AdminOrderTglOrderState extends State<AdminOrderTglOrder> {
  // ignore: non_constant_identifier_names
  onGoBack(dynamic value) {
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    AdminBacaDataVOrderObat(date.toString().substring(0, 10));
  }

  AdminBacaDataVOrderObat(pTgl_order) {
    listOrderTgl.clear();
    Future<String> data = fetchDataAdminVOrderTgl();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        KeranjangOrderClass avlo = KeranjangOrderClass.fromJson(i);
        listOrderTgl.add(avlo);
      }
      setState(() {
        widgetListTglOrder();
      });
    });
  }

  int selected; //agar yg terbuka hanya bisa 1 ListTile

  @override
  void initState() {
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    AdminBacaDataVOrderObat(date.toString().substring(0, 10));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: missing_return
  Widget widgetListTglOrder() {
    if (listOrderTgl.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listOrderTgl.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Center(
                  child: Column(
                    children: [
                      Text(
                          '${listOrderTgl[index].tgl_order.toString().substring(0, 10)}'),
                      Divider(
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminOrderNotaOrder(
                                  tglOrder: listOrderTgl[index]
                                      .tgl_order
                                      .toString()
                                      .substring(0, 10))))
                      .then((value) => onGoBack(value));
                });
          });
    } else
      return Container();
  }

  var controllerdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tanggal Order Obat'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              listOrderTgl.clear();
              ListKadaluarsa.clear();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                widgetListTglOrder(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
