import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';
import 'package:flutter_application_1/admin_order_obat/input_order/admOrderObat_page_input_obat.dart';

//untuk baris list obat pertama pakai query update (study case tgl kadaluarsa berbeda)
//untuk list baris berikutnya, insert obat baru dengan id tertentu.
// tampilan miripin pemilik order obat
DateTime date;

class AdminOrderListObat extends StatefulWidget {
  final adminId, orderId, visitId;

  const AdminOrderListObat({Key key, this.adminId, this.orderId, this.visitId})
      : super(key: key);

  @override
  _AdminOrderListObatState createState() => _AdminOrderListObatState();
}

class _AdminOrderListObatState extends State<AdminOrderListObat> {
  // ignore: non_constant_identifier_names
  onGoBack(dynamic value) {
    AdminBacaDataVListObat(widget.orderId);
    print('widget.orderId ${widget.orderId}');
  }

  // ignore: non_constant_identifier_names
  AdminBacaDataVListObat(pIdOrder) {
    listObatOrder.clear();
    Future<String> data = fetchDataAdminVListObat(pIdOrder);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        KeranjangOrderClass avlo = KeranjangOrderClass.fromJson(i);
        listObatOrder.add(avlo);
      }
      setState(() {
        widgetListObat();
      });
    });
  }

  @override
  void initState() {
    AdminBacaDataVListObat(widget.orderId);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: missing_return
  Widget widgetListObat() {
    if (listObatOrder.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listObatOrder.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Center(
                  child: Column(
                    children: [
                      Text('${listObatOrder[index].id_obat}\n' +
                          '${listObatOrder[index].nama}\n' +
                          'Jumlah Order: ${listObatOrder[index].jumlah_order}'),
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
                          builder: (context) => AdminOrderInputObat(
                                orderId: widget.orderId,
                                obatId: listObatOrder[index].id_obat,
                                obatNama: listObatOrder[index].nama,
                                orderJumlah: listObatOrder[index].jumlah_order,
                                hargaJual: listObatOrder[index].harga_jual,
                                hargaBeli: listObatOrder[index].harga_beli,
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
          title: Text('List Obat'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              listObatOrder.clear();
              ListKadaluarsa.clear();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                widgetListObat(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
