import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_get_list_tindakan.dart';

import 'dr_get_list_obat.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Tanggal Periksa $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class DrRiwayatPeriksaPasien extends StatefulWidget {
  final namaPasien, visitId, keluhan;

  const DrRiwayatPeriksaPasien(
      {Key key, this.namaPasien, this.visitId, this.keluhan})
      : super(key: key);

  @override
  _DrRiwayatPeriksaPasienState createState() => _DrRiwayatPeriksaPasienState();
}

class _DrRiwayatPeriksaPasienState extends State<DrRiwayatPeriksaPasien> {
  // ignore: non_constant_identifier_names
  DokterBacaDataVKeranjangTindakan(pVisitId) {
    dVKTs.clear();
    Future<String> data = fetchDataDokterVKeranjangTindakan(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'error') {
        dVKTs.clear();
        print('json[result]: ${json['result']}');
      } else {
        for (var i in json['data']) {
          DokterVKeranjangTindakan keranjangObat =
              DokterVKeranjangTindakan.fromJson(i);
          dVKTs.add(keranjangObat);
        }
      }
      setState(() {
        widgetKeranjangTindakan();
      });
    });
  }

// nanti diperbaiki sepertinya tidak guna
  // ignore: non_constant_identifier_names
  DokterBacaDataVKeranjangObat(pVisitId) {
    dVLKOs.clear();
    Future<String> data = fetchDataDokterKeranjangObat(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('error $i');
        DokterVKeranjangObat keranjangObat = DokterVKeranjangObat.fromJson(i);
        dVLKOs.add(keranjangObat);
      }
      setState(() {
        widgetListObats();
        for (var i = 0; i < dVLKOs.length; i++) {
          // print(
          //     'id: ${DVLOs[i].obatId}\nnama: ${DVLOs[i].obatNama}\nstok: ${DVLOs[i].obatStok}\n\n\n\n\n\n');
        }
      });
    });
  } // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  DokterBacaDataVListObat(pNamaObat) {
    dVLOs.clear();
    Future<String> data = fetchDataDokterVListObat(pNamaObat);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        DokterVListObat dvlo = DokterVListObat.fromJson(i);
        dVLOs.add(dvlo);
      }
      setState(() {
        widgetListObats();
        for (var i = 0; i < dVLOs.length; i++) {
          // print(
          //     'id: ${DVLOs[i].obatId}\nnama: ${DVLOs[i].obatNama}\nstok: ${DVLOs[i].obatStok}\n\n\n\n\n\n');
        }
      });
    });
  }

  // ignore: non_constant_identifier_names
  DokterBacaDataVListTindakan() {
    dVLTs.clear();
    Future<String> data = fetchDataDokterVListTindakan();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        DokterVListTindakan dvlt = DokterVListTindakan.fromJson(i);
        dVLTs.add(dvlt);
      }
      setState(() {});
    });
  }

  // ignore: non_constant_identifier_names
  DokterBacaDataVCariListTindakan(pTindakan) {
    dVLTs.clear();
    Future<String> data = fetchDataDokterVCariListTindakan(pTindakan);
    data.then((value) {
      // print(value);
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        DokterVListTindakan dvlt = DokterVListTindakan.fromJson(i);
        dVLTs.add(dvlt);
      }
      setState(() {});
    });
  }

  Widget widgetCariObat() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariObat,
              onChanged: (value) {
                setState(() {
                  controllerCariObat.text = value.toString();
                  controllerCariObat.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerCariObat.text.length));
                  // print(value.toString());
                });
              },
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
              DokterBacaDataVListObat(controllerCariObat.text);
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

  int selectedObat; //agar yg terbuka hanya bisa 1 ListTile
  // ignore: missing_return
  Widget widgetListObats() {
    if (dVLOs.length > 0) {
      return ListView.builder(
          key: Key(
              'builder ${selectedObat.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dVLOs.length,
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
                              selectedObat, //agar yg terbuka hanya bisa 1 ListTile
                          onExpansionChanged: ((newState) {
                            if (newState)
                              setState(() {
                                selectedObat = index;
                              });
                            else
                              setState(() {
                                selectedObat = -1;
                              });
                          }),
                          title: Text(
                            '${dVLOs[index].obatNama}',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'STOK: ${dVLOs[index].obatStok}',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
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
                                        onChanged: (value) {
                                          setState(() {
                                            controllerJumlah.text =
                                                value.toString();
                                            controllerJumlah.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controllerJumlah
                                                            .text.length));
                                          });
                                        },
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
                                        controller: controllerDosis,
                                        // keyboardType: TextInputType.number,
                                        // inputFormatters: <TextInputFormatter>[
                                        //   FilteringTextInputFormatter.digitsOnly
                                        // ],
                                        onChanged: (value) {
                                          setState(() {
                                            controllerDosis.text =
                                                value.toString();
                                            controllerDosis.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controllerDosis
                                                            .text.length));
                                            // print(value.toString());
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Dosis",
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
                                  DokterVKeranjangObat tambahObat =
                                      DokterVKeranjangObat();
                                  tambahObat.obatNama = dVLOs[index].obatNama;
                                  tambahObat.obatId = dVLOs[index].obatId;
                                  tambahObat.obatDosis = controllerDosis.text;
                                  tambahObat.obatJumlah = controllerJumlah.text;
                                  dVLKOs.add(tambahObat);
                                  setState(() {
                                    widgetKeranjangObatBody();
                                  });
                                  controllerJumlah.text = '';
                                  controllerDosis.text = '';
                                  // fetchDataDokterInputResepObat(
                                  //         dVLOs[index].obatId,
                                  //         controllerDosis.text,
                                  //         controllerJumlah.text,
                                  //         widget.visitId)
                                  //     .then((value) => showDialog<String>(
                                  //           context: context,
                                  //           builder: (BuildContext context) =>
                                  //               AlertDialog(
                                  //             title: Text(
                                  //               'Obat berhasil ditambah ke resep',
                                  //               style: TextStyle(fontSize: 14),
                                  //             ),
                                  //             actions: <Widget>[
                                  //               TextButton(
                                  //                   onPressed: () {
                                  //                     controllerJumlah.clear();
                                  //                     controllerDosis.clear();
                                  //                     setState(() {
                                  //                       widgetListObats();
                                  //                     });
                                  //                     Navigator.pop(
                                  //                       context,
                                  //                       'ok',
                                  //                     );
                                  //                   },
                                  //                   child: Text('ok')),
                                  //             ],
                                  //           ),
                                  //         ));
                                  // DokterBacaDataVKeranjangObat(widget.visitId);
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
                          ])
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  Widget widgetCariTindakan() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariTindakan,
              decoration: InputDecoration(
                labelText: "Tindakan",
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
              DokterBacaDataVCariListTindakan(controllerCariTindakan.text);
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

  var sisiMataKiri, sisiMataKanan = '';
  int selectedTindakan; //agar yg terbuka hanya bisa 1 ListTile
  // ignore: missing_return
  Widget widgetLisTindakans() {
    if (dVLTs.length > 0) {
      return ListView.builder(
          key: Key(
              'builder ${selectedTindakan.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dVLTs.length,
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
                              selectedTindakan, //agar yg terbuka hanya bisa 1 ListTile
                          onExpansionChanged: ((newState) {
                            if (newState)
                              setState(() {
                                selectedTindakan = index;
                              });
                            else
                              setState(() {
                                selectedTindakan = -1;
                              });
                          }),
                          title: Text(
                            '${dVLTs[index].namaTindakan}',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
                            CheckboxListTile(
                              title: Text('kiri'),
                              value: listValueCheckKiri,
                              onChanged: (bool value) {
                                listValueCheckKiri = value;
                                if (value == true) {
                                  setState(() {
                                    sisiMataKiri = 'kiri';
                                  });
                                } else {
                                  setState(() {
                                    sisiMataKiri = '';
                                  });
                                }
                                print('listValueCheckKiri : $sisiMataKiri');
                              },
                            ),
                            CheckboxListTile(
                              title: Text('kanan'),
                              value: listValueCheckKanan,
                              onChanged: (bool value) {
                                listValueCheckKanan = value;
                                if (value == true) {
                                  setState(() {
                                    sisiMataKanan = 'kanan';
                                  });
                                } else {
                                  setState(() {
                                    sisiMataKanan = '';
                                  });
                                }
                                print('listValueCheckKanan : $sisiMataKanan');
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // kalau pnly kiri/kanan > input 1x
                                if (sisiMataKiri == 'kiri' &&
                                    sisiMataKanan != 'kanan') {
                                  DokterVKeranjangTindakan tdkn =
                                      DokterVKeranjangTindakan();
                                  tdkn.namaTindakan = dVLTs[index].namaTindakan;
                                  tdkn.tindakanId = dVLTs[index].idTindakan;
                                  tdkn.mataSisiTindakan = 'kiri';
                                  dVKTs.add(tdkn);
                                  print('kiri');
                                } else if (sisiMataKanan == 'kanan' &&
                                    sisiMataKiri != 'kiri') {
                                  DokterVKeranjangTindakan tdkn =
                                      DokterVKeranjangTindakan();
                                  tdkn.namaTindakan = dVLTs[index].namaTindakan;
                                  tdkn.tindakanId = dVLTs[index].idTindakan;
                                  tdkn.mataSisiTindakan = 'kanan';
                                  dVKTs.add(tdkn);
                                  print('kanan');
                                }
                                // kalau kanan dan kiri > input 2x
                                else if (sisiMataKanan == 'kanan' &&
                                    sisiMataKiri == 'kiri') {
                                  DokterVKeranjangTindakan tdkn =
                                      DokterVKeranjangTindakan();
                                  tdkn.namaTindakan = dVLTs[index].namaTindakan;
                                  tdkn.tindakanId = dVLTs[index].idTindakan;
                                  tdkn.mataSisiTindakan = 'kanan';
                                  dVKTs.add(tdkn);
                                  print('kanan');
                                  DokterVKeranjangTindakan tdkns =
                                      DokterVKeranjangTindakan();
                                  tdkns.namaTindakan =
                                      dVLTs[index].namaTindakan;
                                  tdkns.tindakanId = dVLTs[index].idTindakan;
                                  tdkns.mataSisiTindakan = 'kiri';
                                  dVKTs.add(tdkns);
                                  print('kiri');
                                }
                                setState(() {
                                  listValueCheckKanan = false;
                                  listValueCheckKiri = false;
                                  sisiMataKiri = '';
                                  sisiMataKanan = '';
                                });
                              },
                              child: Text('Tambah'),
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.01)),
                            )
                          ])
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerDosis = TextEditingController();
  TextEditingController controllerKeluhan = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  TextEditingController controllerCariTindakan = TextEditingController();

  @override
  void initState() {
    controllerKeluhan.text = widget.keluhan;
    controllerKeluhan.addListener(() {
      setState(() {});
    });
    DokterBacaDataVListTindakan();
    DokterBacaDataVListObat('');
    DokterBacaDataVKeranjangObat(widget.visitId);
    // for (var index = 0; index < dVKTs.length; index++) {
    //   fetchDataDokterInputTindakanBatal(
    //           widget.visitId, dVKTs[index].tindakanId, 'kiri')
    //       .then((value) => DokterBacaDataVKeranjangTindakan(widget.visitId));
    //   fetchDataDokterInputTindakanBatal(
    //           widget.visitId, dVKTs[index].tindakanId, 'kanan')
    //       .then((value) => DokterBacaDataVKeranjangTindakan(widget.visitId));
    // }
    super.initState();
  }

  @override
  void dispose() {
    controllerKeluhan.dispose();
    super.dispose();
  }

  var listValueCheckKiri = false;
  var listValueCheckKanan = false;
  Widget widgetKeranjangObatBody() {
    if (dVLKOs.length > 0) {
      return Column(
        children: [
          Table(
              columnWidths: {
                0: FlexColumnWidth(2.5),
                1: FlexColumnWidth(2.5),
                2: FlexColumnWidth(2.5),
                3: FlexColumnWidth(2.5),
              },
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
                    'Dosis',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dVLKOs.length,
              itemBuilder: (context, index) {
                return Table(
                    columnWidths: {
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(2.5),
                      2: FlexColumnWidth(2.5),
                      3: FlexColumnWidth(2.5),
                    },
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          '${dVLKOs[index].obatNama}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${dVLKOs[index].obatJumlah}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${dVLKOs[index].obatDosis}',
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () {
                              dVLKOs.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ]),
                    ]);
              }),
        ],
      );
    } else
      return Container();
  }

  Widget widgetKeranjangTindakan() {
    if (dVKTs.length > 0) {
      return Column(
        children: [
          Table(
              columnWidths: {
                0: FlexColumnWidth(2.5),
                1: FlexColumnWidth(2.5),
                2: FlexColumnWidth(1.64),
              },
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Nama',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Mata Sisi',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dVKTs.length,
              itemBuilder: (context, index) {
                return Table(
                    columnWidths: {
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(2.5),
                      2: FlexColumnWidth(1.64),
                    },
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          '${dVKTs[index].namaTindakan}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${dVKTs[index].mataSisiTindakan}',
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () {
                              dVKTs.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ]),
                    ]);
              }),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ],
      );
    } else {
      return Row(
        children: [Container()],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dVLTs.length > 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Input Pemeriksaan'),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.green[50],
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.namaPasien}',
                                style: TextStyle(fontSize: 22),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                // initialValue: widget.keluhan,
                                controller: controllerKeluhan,
                                decoration: InputDecoration(
                                  labelText: "keluhan",
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                initialValue: 'tidak ada',
                                decoration: InputDecoration(
                                  labelText: "anamnesis",
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
                          widgetKeranjangTindakan(),
                          widgetKeranjangObatBody(),
                          ExpansionTile(
                              title: Text(
                                'Input Tindakan',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              children: [
                                widgetCariTindakan(),
                                widgetLisTindakans(),
                              ]),
                          ExpansionTile(
                              title: Text(
                                'Input Resep',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              children: [
                                widgetCariObat(),
                                widgetListObats(),
                              ]),
                          WidgetButtonSimpan(context)
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
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Riwayat Periksa: ${widget.namaPasien}'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }

  var enableBtn = true;
  ElevatedButton WidgetButtonSimpan(BuildContext context) {
    if (enableBtn == false) {
      return ElevatedButton(
        child: Text('BACK'),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          //kirim data tindakan
          for (var i = 0; i < dVKTs.length; i++) {
            fetchDataDokterInputTindakan(widget.visitId, dVKTs[i].tindakanId,
                    dVKTs[i].mataSisiTindakan)
                .then((value) {
              if (i == dVKTs.length - 1) {
                print('last dVKTs $i');
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Input Tindakan Berhasil',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          enableBtn = false;
                          dVKTs.clear();
                          setState(() {
                            widgetLisTindakans();
                            WidgetButtonSimpan(context);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ok',
                        ),
                      ),
                    ],
                  ),
                );
              }
            });
          }

          for (var i = 0; i < dVLKOs.length; i++) {
            fetchDataDokterInputResepObat(dVLKOs[i].obatId, dVLKOs[i].obatDosis,
                    dVLKOs[i].obatJumlah, widget.visitId)
                .then((value) {
              if (i == dVLKOs.length - 1) {
                print('last dVLKOs $i');
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Input Obat Berhasil',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          dVLKOs.clear();
                          enableBtn = false;
                          setState(() {
                            widgetListObats();
                            WidgetButtonSimpan(context);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Ok',
                          // style: TextStyle(
                          //     fontSize: 14,
                          //     backgroundColor: Colors.blue,
                          //     color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
            });
          }
        },
        child: Text('SIMPAN'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.04)),
      );
    }
  }
}
