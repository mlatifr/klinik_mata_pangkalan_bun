import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';
import 'package:flutter_application_1/apoteker/apt_get_resep_pasien_detail.dart';
import 'package:flutter_application_1/pemilik/input_order/pemilik_model.dart';
import 'package:flutter_application_1/pemilik/pemilik_fetch/pemilik_send_input_order.dart';

DateTime date;

class AdminOrderInputKonfirmasiObat extends StatefulWidget {
  final adminId, namaPasien, visitId;

  const AdminOrderInputKonfirmasiObat(
      {Key key, this.adminId, this.namaPasien, this.visitId})
      : super(key: key);

  @override
  _AdminOrderInputKonfirmasiObatState createState() =>
      _AdminOrderInputKonfirmasiObatState();
}

class _AdminOrderInputKonfirmasiObatState
    extends State<AdminOrderInputKonfirmasiObat> {
  // ignore: non_constant_identifier_names
  AdminBacaDataVOrderObat(pTgl_order) {
    listOrderObats.clear();
    Future<String> data = fetchDataAdminVOrderObat(pTgl_order);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        KeranjangOrderClass avlo = KeranjangOrderClass.fromJson(i);
        listOrderObats.add(avlo);
      }
      ListDiterima.clear();
      // print("widgetKeranjangObatBodyPemilik: ${ListInputResep.length}");
      for (var i = 0; i < listOrderObats.length; i++) {
        TextEditingController txtDiterima = TextEditingController();
        txtDiterima.text = (listOrderObats[i].jumlah_order).toString();
        ListDiterima.add(txtDiterima);
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
  Widget widgetListObats() {
    if (listOrderObats.length > 0) {
      return ListView.builder(
          // key: Key(
          //     'builder ${selected.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listOrderObats.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                        '${listOrderObats[index].nama} \n'
                        '${listOrderObats[index].tgl_order.toString().substring(0, 10)}\n'
                        'Jumlah Order: \n${listOrderObats[index].jumlah_order.toString()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                      //listOrderObats[index].jumlah_order.toString(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            enabled: true,
                            controller: ListDiterima[index],
                            // initialValue:
                            //     listOrderObats[index].jumlah_order.toString(),
                            // onChanged: (value) {
                            //   listOrderObats[index].jumlah_diterima = value;
                            //   print('${listOrderObats[index].jumlah_diterima}');
                            // },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: "Diterima",
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            );
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
          title: Text('Input Order Obat'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              listOrderObats.clear();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: controllerdate,
                          onChanged: (value) {
                            setState(() {
                              controllerdate.text = value.toString();
                              controllerdate.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: controllerdate.text.length));
                              // print(value.toString());
                              AdminBacaDataVOrderObat(value.substring(0, 10));
                            });
                          },
                          enabled: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'Tanggal Visit',
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
                                  controllerdate.text =
                                      value.toString().substring(0, 10);
                                  // print(value.toString());
                                  AdminBacaDataVOrderObat(controllerdate.text);
                                  // print('elevatedButton');
                                });
                              });
                            },
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.white,
                              size: 24.0,
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                                title: Text(
                                  'Input Obat',
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  // widgetCariObat(),
                                  widgetListObats(),
                                ])),
                        ElevatedButton(
                            onPressed: () {
                              if (listOrderObats.isNotEmpty) {
                                for (var i = 0;
                                    i < listOrderObats.length;
                                    i++) {
                                  listOrderObats[i].status_order = 'diterima';
                                  listOrderObats[i].jumlah_diterima =
                                      ListDiterima[i].text;
                                  // print('nama: ${listOrderObats[i].nama}\n' +
                                  //     '| id_obat: ${listOrderObats[i].id_obat}\n' +
                                  //     '|jumlah_diterima: ${listOrderObats[i].jumlah_diterima}\n' +
                                  //     '|status_order: ${listOrderObats[i].status_order}|');
                                  fetchDataAdminUpdateOrderObat(
                                          listOrderObats[i].jumlah_diterima,
                                          listOrderObats[i].jumlah_diterima,
                                          '2022-2-2',
                                          listOrderObats[i].status_order,
                                          listOrderObats[i].id_obat)
                                      .then((value) {
                                    Map json = jsonDecode(value);
                                    if (json['data']
                                        .toString()
                                        .contains('success')) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                            '$value',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('ok')),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                }
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Keranjang tidak Boleh Kosong',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ok')),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text('SIMPAN'))
                      ],
                    ),
                  ),
                ),
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
