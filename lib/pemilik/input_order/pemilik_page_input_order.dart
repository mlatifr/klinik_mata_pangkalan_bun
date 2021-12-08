import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/apoteker/apt_get_resep_pasien_detail.dart';
import 'package:flutter_application_1/dokter/dr_get_list_obat.dart';
import 'package:flutter_application_1/pemilik/input_order/pemilik_model.dart';

class PemilikInputOrderObat extends StatefulWidget {
  final aptkrId, namaPasien, visitId;

  const PemilikInputOrderObat(
      {Key key, this.aptkrId, this.namaPasien, this.visitId})
      : super(key: key);

  @override
  _PemilikInputOrderObatState createState() => _PemilikInputOrderObatState();
}

class _PemilikInputOrderObatState extends State<PemilikInputOrderObat> {
// ignore: non_constant_identifier_names
  ApotekerBacaDataVKeranjangResepApoteker(pVisitId) {
    aVKOs.clear();
    Future<String> data = fetchDataApotekerVKeranjangResepApotekerId(pVisitId);
    data.then((value) {
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'success') {
        for (var i in json['data']) {
          ApotekerVKeranjangObat keranjangObatDokter =
              ApotekerVKeranjangObat.fromJson(i);
          aVKOs.add(keranjangObatDokter);
          // print('AVKOs[length]: ${aVKOs.length}');
        }
        setState(() {
          widgetKeranjangObatBodyPemilik();
        });
      }
    });
  }

// ignore: non_constant_identifier_names
  ApotekerInputDataResepObat(pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) {
    aVKOs.clear();
    Future<String> data = fetchDataApotekerInputResepObat(
        pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId);
    data.then((value) {
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'success') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Obat berhasil ditambah ke resep',
              style: TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    controllerJumlah.clear();
                    controllerHargaBeli.clear();
                    setState(() {
                      widgetListObats();
                    });
                    Navigator.pop(
                      context,
                      'ok',
                    );
                  },
                  child: Text('ok')),
            ],
          ),
        );
        for (var i in json['data']) {
          ApotekerVKeranjangObat keranjangObatDokter =
              ApotekerVKeranjangObat.fromJson(i);
          aVKOs.add(keranjangObatDokter);
          print('AVKOs[length]: ${aVKOs.length}');
        }
        setState(() {
          ApotekerBacaDataVKeranjangResepApoteker(widget.visitId);
          // widgetKeranjangObatBodyPemilik();
        });
      }
    }).then((value) {
      setState(() {
        widgetKeranjangObatBodyPemilik();
      });
    });
  }

  // // ignore: non_constant_identifier_names
  // ApotekerBacaDataVKeranjangResepDokter(pVisitId) {
  //   aVKODrs.clear();
  //   Future<String> data = fetchDataDokterKeranjangObat(pVisitId);
  //   data.then((value) {
  //     //Mengubah json menjadi Array
  //     // ignore: unused_local_variable
  //     Map json = jsonDecode(value);
  //     for (var i in json['data']) {
  //       ApotekerVKeranjangObatDokter keranjangObatDokter =
  //           ApotekerVKeranjangObatDokter.fromJson(i);
  //       aVKODrs.add(keranjangObatDokter);
  //     }
  //     setState(() {
  //       widgetListObats();
  //     });
  //   });
  // }

  // ignore: non_constant_identifier_names
  PemilikBacaDataVListObat(pNamaObat) {
    aVLOs.clear();
    Future<String> data = fetchDataApotekerVListObat(pNamaObat);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ApotekerrVListObat avlo = ApotekerrVListObat.fromJson(i);
        aVLOs.add(avlo);
      }
      setState(() {
        widgetListObats();
      });
    });
  }

  Widget widgetCariObat() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariObat,
              // onChanged: (value) {
              //   setState(() {
              //     controllerCariObat.text = value.toString();
              //     controllerCariObat.selection = TextSelection.fromPosition(
              //         TextPosition(offset: controllerCariObat.text.length));
              //   });
              // },
              decoration: InputDecoration(
                labelText: "Resep",
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.search),
                ),
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
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: TextButton(
            onPressed: () {
              PemilikBacaDataVListObat(controllerCariObat.text);
            },
            child: Text(
              'Cari',
            ),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.01)),
          ),
        ),
      ],
    );
  }

  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerHargaBeli = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile
  // ignore: missing_return
  Widget widgetListObats() {
    if (aVLOs.length > 0) {
      return ListView.builder(
          key: Key(
              'builder ${selected.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: aVLOs.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      ExpansionTile(
                          key: Key(index
                              .toString()), //agar yg terbuka hanya bisa 1 ListTile
                          initiallyExpanded: index ==
                              selected, //agar yg terbuka hanya bisa 1 ListTile
                          onExpansionChanged: ((newState) {
                            if (newState)
                              setState(() {
                                selected = index;
                              });
                            else
                              setState(() {
                                selected = -1;
                              });
                          }),
                          title: Text(
                            '${aVLOs[index].obatNama} : ${aVLOs[index].obatStok}',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        enabled: true,
                                        controller: controllerJumlah,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     controllerJumlah.text =
                                        //         value.toString();
                                        //     controllerJumlah.selection =
                                        //         TextSelection.fromPosition(
                                        //             TextPosition(
                                        //                 offset: controllerJumlah
                                        //                     .text.length));
                                        //   });
                                        // },
                                        decoration: InputDecoration(
                                          labelText: "Jumlah",
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        enabled: true,
                                        controller: controllerHargaBeli,
                                        // onChanged: (value) {
                                        //   // setState(() {
                                        //   //   controllerHargaBeli.text =
                                        //   //       value.toString();
                                        //   //   controllerHargaBeli.selection =
                                        //   //       TextSelection.fromPosition(
                                        //   //           TextPosition(
                                        //   //               offset:
                                        //   //                   controllerHargaBeli
                                        //   //                       .text.length));
                                        //   // });
                                        // },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          labelText: "Harga Beli",
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  PemilikInputResepList selectedObat =
                                      PemilikInputResepList(
                                          obatNama: aVLOs[index].obatNama,
                                          jumlah_order: controllerJumlah.text,
                                          harga_beli: controllerHargaBeli.text);
                                  ListKeranjangObat.add(selectedObat);
                                  setState(() {
                                    widgetKeranjangObatBodyPemilik();
                                  });
                                  print(ListKeranjangObat.length);
                                  // ApotekerInputDataResepObat(
                                  // aptkrRspId,
                                  // aVLOs[index].obatId,
                                  // controllerHargaBeli.text,
                                  // controllerJumlah.text,
                                  // widget.visitId);
                                },
                                child: Text('tambah'),
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height *
                                            0.01)),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  Widget widgetKeranjangObatHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Table(
          border: TableBorder
              .all(), // Allows to add a border decoration around your table
          children: [
            TableRow(children: [
              Text(
                'Obat',
                textAlign: TextAlign.center,
              ),
              Text(
                'Jumlah',
                textAlign: TextAlign.center,
              ),
              Text(
                'Harga Beli',
                textAlign: TextAlign.center,
              ),
              Text(
                'Harga Jual',
                textAlign: TextAlign.center,
              ),
            ]),
          ]),
    );
  }

  Widget widgetKeranjangObatBodyPemilik() {
    ListHargaJual.clear();
    // print("widgetKeranjangObatBodyPemilik: ${ListInputResep.length}");
    for (var i = 0; i < ListKeranjangObat.length; i++) {
      TextEditingController txtHrgJual = TextEditingController();
      txtHrgJual.text = (i - i).toString();
      ListHargaJual.add(txtHrgJual);
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ListKeranjangObat.length,
          itemBuilder: (context, index) {
            return Table(
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${ListKeranjangObat[index].obatNama}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${ListKeranjangObat[index].jumlah_order}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${ListKeranjangObat[index].harga_beli}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          enabled: true,
                          controller: ListHargaJual[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          // onChanged: (value) {
                          //   setState(() {
                          //     controllerJumlah.text =
                          //         value.toString();
                          //     controllerJumlah.selection =
                          //         TextSelection.fromPosition(
                          //             TextPosition(
                          //                 offset: controllerJumlah
                          //                     .text.length));
                          //   });
                          // },
                          decoration: InputDecoration(
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
                  ]),
                ]);
          }),
    );
  }

  // Widget widgetKeranjangObatBodyPemilik() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: ListView.builder(
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: aVKOs.length,
  //         itemBuilder: (context, index) {
  //           return Table(
  //               border: TableBorder
  //                   .all(), // Allows to add a border decoration around your table
  //               children: [
  //                 TableRow(children: [
  //                   Text(
  //                     '${aVKOs[index].nama}',
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   Text(
  //                     '${aVKOs[index].jumlah}',
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   Text(
  //                     '${aVKOs[index].dosis}',
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ]),
  //               ]);
  //         }),
  //   );
  // }

  Widget widgetKeranjangObatDokterBody() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: aVKODrs.length,
          itemBuilder: (context, index) {
            return Table(
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Text(
                      '${aVKODrs[index].nama}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${aVKODrs[index].jumlah}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${aVKODrs[index].dosis}',
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ]);
          }),
    );
  }

  var aptkrRspId;
  // ignore: non_constant_identifier_names
  ApotekerBacaDataRspVst() {
    aptkrRspId = '';
    Future<String> data = fetchDataApotekerInputRspVst(
      widget.visitId,
      widget.aptkrId,
      DateTime.now().toString().substring(0, 10),
    );
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      aptkrRspId = json['id_resep_apoteker'].toString();
      print('ApotekerBacaDataRspVst(): $aptkrRspId');
      // for (var i in json['data']) {
      //   print(i);
      //   ApotekerVAntrean dva = ApotekerVAntrean.fromJson(i);
      // }
      setState(() {});
    });
  }

// ignore: non_constant_identifier_names
  ApotekerBacaInputResepObat(pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) {
    // AptkrRspId = '';
    Future<String> data = ApotekerBacaInputResepObat(
        pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      // AptkrRspId = json['id_resep_apoteker'].toString();
      // print('ApotekerBacaDataRspVst(): $AptkrRspId');
      for (var i in json['data']) {
        print(i);
        // ApotekerVAntrean dva = ApotekerVAntrean.fromJson(i);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    // ApotekerBacaDataRspVst();
    // ApotekerBacaDataVKeranjangResepApoteker(widget.visitId);
    // ApotekerBacaDataVKeranjangResepDokter(widget.visitId);
    controllerCariObat.clear();
    PemilikBacaDataVListObat(controllerCariObat.text);
    ListInputResep.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        // widgetKeranjangObatHeader(),
                        // widgetKeranjangObatDokterBody(),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                                title: Text(
                                  'Input Obat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                                children: [
                                  widgetCariObat(),
                                  widgetListObats(),
                                ])),
                        ExpansionTile(
                          title: Text(
                            'Keranjang Obat',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
                            widgetKeranjangObatHeader(),
                            widgetKeranjangObatBodyPemilik(),
                          ],
                        ),

                        ElevatedButton(
                            onPressed: () {
                              //   for (var item in ListInputResep) {
                              //     fetchDataApotekerInputResepObat(
                              //             item.rspAptkrId,
                              //             item.obtId,
                              //             item.dosis,
                              //             item.jumlah,
                              //             item.visitId)
                              //         .then((value) {
                              //       print(value);
                              //     });
                              //   }
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
