import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';
import 'package:flutter_application_1/admin_order_obat/input_order/admOrderObat_page_nota_order.dart';

//untuk baris list obat pertama pakai query update (study case tgl kadaluarsa berbeda)
//untuk list baris berikutnya, insert obat baru dengan id tertentu.
// tampilan miripin pemilik order obat
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
      ListDiterima.clear();
      // print("widgetKeranjangObatBodyPemilik: ${ListInputResep.length}");
      for (var i = 0; i < listOrderTgl.length; i++) {
        TextEditingController txtDiterima = TextEditingController();
        txtDiterima.text = (listOrderTgl[i].jumlah_order).toString();
        ListDiterima.add(txtDiterima);

        TextEditingController txtKadaluarsa = TextEditingController();
        txtKadaluarsa.text = (listOrderTgl[i].kadaluarsa).toString();
        ListKadaluarsa.add(txtKadaluarsa);
      }
      setState(() {});
    });
  }

  TextEditingController controllerObatNama = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerHargaBeli = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile

  @override
  void initState() {
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    controllerCariObat.clear();
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
          // key: Key(
          //     'builder ${selected.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
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
                                  .substring(0, 10))));
                });
          });
    } else
      return Container();
  }

  var controllerdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (aVKODrs.length > 0) {
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
    // } else {
    //   return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       appBar: AppBar(
    //         centerTitle: true,
    //         title: Text('Resep: ${widget.namaPasien}'),
    //         leading: new IconButton(
    //           icon: new Icon(Icons.arrow_back),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ),
    //       body: Center(child: CircularProgressIndicator()),
    //     ),
    //   );
    // }
  }
}
