import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';
import 'package:flutter_application_1/admin_order_obat/input_order/admOrderObat_page_list_obat.dart';

DateTime date;

class AdminOrderNotaOrder extends StatefulWidget {
  final adminId, tglOrder, visitId;

  const AdminOrderNotaOrder(
      {Key key, this.adminId, this.tglOrder, this.visitId})
      : super(key: key);

  @override
  _AdminOrderNotaOrderState createState() => _AdminOrderNotaOrderState();
}

class _AdminOrderNotaOrderState extends State<AdminOrderNotaOrder> {
  // ignore: non_constant_identifier_names
  AdminBacaDataVOrderObat(pTgl_order) {
    listOrderId.clear();
    Future<String> data = fetchDataAdminVOrderNota(pTgl_order);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        KeranjangOrderClass avlo = KeranjangOrderClass.fromJson(i);
        listOrderId.add(avlo);
      }
      setState(() {
        widgetListNotaOrder();
      });
    });
  }

  @override
  void initState() {
    AdminBacaDataVOrderObat(widget.tglOrder);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: missing_return
  Widget widgetListNotaOrder() {
    if (listOrderId.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listOrderId.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Center(
                  child: Column(
                    children: [
                      Text('Nota id: ${listOrderId[index].id_order}'),
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
                          builder: (context) => AdminOrderListObat(
                                orderId: listOrderId[index].id_order,
                              )));
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
          title: Text('Nota Order Obat'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              listOrderId.clear();
              ListKadaluarsa.clear();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                widgetListNotaOrder(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
