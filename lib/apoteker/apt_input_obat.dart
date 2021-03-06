import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apt_get_resep_pasien_detail.dart';

class AptInputObat extends StatefulWidget {
  final aptkrId, namaPasien, visitId, namaPembeli, rspId;

  const AptInputObat(
      {Key key,
      this.aptkrId,
      this.namaPasien,
      this.visitId,
      this.namaPembeli,
      this.rspId})
      : super(key: key);

  @override
  _AptInputObatState createState() => _AptInputObatState();
}

class _AptInputObatState extends State<AptInputObat> {
  // ignore: non_constant_identifier_names
  ApotekerBacaDataVKeranjangResepDokter(pVisitId) {
    aVKODrs.clear();
    // Future<String> data = fetchDataDokterKeranjangObat(pVisitId);
    Future<String> data = fetchDataApotekerKeranjangObatDokter(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ApotekerVKeranjangObatDokter keranjangObatDokter =
            ApotekerVKeranjangObatDokter.fromJson(i);
        aVKODrs.add(keranjangObatDokter);
      }
      setState(() {
        widgetListObats();
      });
    });
  }

  // ignore: non_constant_identifier_names
  ApotekerBacaDataVListObat(pNamaObat) {
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
              onChanged: (value) {
                setState(() {
                  controllerCariObat.text = value.toString();
                  controllerCariObat.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerCariObat.text.length));
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
              ApotekerBacaDataVListObat(controllerCariObat.text);
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

  Widget widgetTextKadaluarsa(index) {
    if (aVLOs[index].kadaluarsa != null) {
      return Text(
          'Kadaluarsa ${aVLOs[index].kadaluarsa.toString().substring(0, 10)}');
    } else {
      return Text('Kadaluarsa ${aVLOs[index].kadaluarsa}');
    }
  }

  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerDosis = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  TextEditingController controllerNamaPembeli = TextEditingController();
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
                          title: Column(
                            children: [
                              Text(
                                '${aVLOs[index].obatNama}',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              widgetTextKadaluarsa(index),
                            ],
                          ),
                          children: [
                            Text('Stok: ${aVLOs[index].obatStok}'),
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
                                  var jumlah = controllerJumlah.text;
                                  var dosis = controllerDosis.text;
                                  if (ListInputResep.isEmpty) {
                                    Future<String> data =
                                        fetchDataApotekerInputRspVst(
                                      widget.visitId,
                                      widget.aptkrId,
                                      DateTime.now()
                                          .toString()
                                          .substring(0, 10),
                                    );
                                    data.then((value) {
                                      // print('controllerJumlah $jumlah | ${controllerJumlah.text}\n' +
                                      //     'controllerDosis $dosis | ${controllerDosis.text}');
                                      //Mengubah json menjadi Array
                                      // ignore: unused_local_variable
                                      Map json = jsonDecode(value);
                                      aptkrRspId =
                                          json['id_resep_apoteker'].toString();
                                      // setState(() {
                                      //   print('aptkrRspId $aptkrRspId');
                                      // });
                                      if (widget.visitId != null) {
                                        ApotekerInputResepList selectedObat =
                                            ApotekerInputResepList(
                                                rspAptkrId: aptkrRspId,
                                                obtId: aVLOs[index].obatId,
                                                obatNama: aVLOs[index].obatNama,
                                                dosis: dosis,
                                                jumlah: jumlah,
                                                visitId: widget.visitId);
                                        print('rspAptkrId ${selectedObat.rspAptkrId}\n' +
                                            'jumlah ${selectedObat.jumlah}\n' +
                                            'dosis ${selectedObat.dosis}\n' +
                                            'obatId ${aVLOs[index].obatId}');
                                        ListInputResep.add(selectedObat);
                                      } else {
                                        ApotekerInputResepList selectedObat =
                                            ApotekerInputResepList(
                                                rspAptkrId: widget.rspId,
                                                obtId: aVLOs[index].obatId,
                                                obatNama: aVLOs[index].obatNama,
                                                dosis: controllerDosis.text,
                                                jumlah: controllerJumlah.text,
                                                namaPembeli:
                                                    controllerNamaPembeli.text);
                                        ListInputResep.add(selectedObat);
                                      }
                                      setState(() {
                                        widgetKeranjangObatApotekerBody();
                                      });
                                    });
                                  } else {
                                    if (widget.visitId != null) {
                                      ApotekerInputResepList selectedObat =
                                          ApotekerInputResepList(
                                              rspAptkrId: aptkrRspId,
                                              obtId: aVLOs[index].obatId,
                                              obatNama: aVLOs[index].obatNama,
                                              dosis: controllerDosis.text,
                                              jumlah: controllerJumlah.text,
                                              visitId: widget.visitId);
                                      ListInputResep.add(selectedObat);
                                    } else {
                                      ApotekerInputResepList selectedObat =
                                          ApotekerInputResepList(
                                              rspAptkrId: widget.rspId,
                                              obtId: aVLOs[index].obatId,
                                              obatNama: aVLOs[index].obatNama,
                                              dosis: controllerDosis.text,
                                              jumlah: controllerJumlah.text,
                                              namaPembeli:
                                                  controllerNamaPembeli.text);
                                      ListInputResep.add(selectedObat);
                                    }
                                  }

                                  controllerJumlah.text = '';
                                  controllerDosis.text = '';
                                  setState(() {
                                    widgetKeranjangObatApotekerBody();
                                  });
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

  Widget widgetKeranjangObatApotekerBody() {
    if (ListInputResep.length != 0) {
      return Column(
        children: [
          Padding(
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
                      'Dosis',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '',
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ListInputResep.length,
                itemBuilder: (context, index) {
                  return Table(
                      border: TableBorder
                          .all(), // Allows to add a border decoration around your table
                      children: [
                        TableRow(children: [
                          Text(
                            '${ListInputResep[index].obatNama}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${ListInputResep[index].jumlah}',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${ListInputResep[index].dosis}',
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () {
                                ListInputResep.removeAt(index);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ]),
                      ]);
                }),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

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
  ApotekerBacaDataInpuRsp() {
    //untuk input pada table resep, sebelum input table resep_has_obat
    aptkrRspId = '';
    if (widget.visitId != null) {
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
        setState(() {
          print('aptkrRspId $aptkrRspId');
        });
      });
    }
  }

// ignore: non_constant_identifier_names
  ApotekerBacaInputResepObat(pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) {
    Future<String> data = ApotekerBacaInputResepObat(
        pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      setState(() {});
    });
  }

  @override
  void initState() {
    aVKODrs.clear();
    // ApotekerBacaDataInpuRsp();
    if (widget.visitId != null) {
      // ApotekerBacaDataInpuRsp();
      ApotekerBacaDataVKeranjangResepDokter(widget.visitId);
    }

    controllerCariObat.clear();
    ApotekerBacaDataVListObat(controllerCariObat.text);
    ListInputResep.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var btnSimpan = true;
  // ignore: missing_return
  Widget widgetButtonSimpan() {
    if (btnSimpan == true) {
      return TextButton(
        onPressed: () {
          showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Apakah Anda yakin akan menyimpan?',
                style: TextStyle(fontSize: 14),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'batal',
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () {
                    for (var i = 0; i < ListInputResep.length; i++) {
                      fetchDataApotekerInputResepObat(
                              ListInputResep[i].rspAptkrId,
                              ListInputResep[i].obtId,
                              ListInputResep[i].dosis,
                              ListInputResep[i].jumlah)
                          .then((value) {
                        if (i == ListInputResep.length - 1 &&
                            value.toString().contains('success')) {
                          showDialog<String>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Input Obat Berhasil',
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      btnSimpan = false;
                                      widgetButtonSimpan();
                                    });
                                    Navigator.pop(context);
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
                  },
                  child: Text(
                    'Simpan',
                  ),
                ),
              ],
            ),
          );
        },
        child: Text('SIMPAN'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(MediaQuery.of(context).size.width, 10)),
      );
    }
    if (btnSimpan == false) {
      return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('BACK'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(MediaQuery.of(context).size.width, 10)),
      );
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (aVKODrs.length > 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Input Resep'),
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
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Resep Dokter:\n${widget.namaPasien}',
                                style: TextStyle(fontSize: 22),
                              )),
                          widgetKeranjangObatDokterBody(),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                  title: Text(
                                    'Input Resep',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  children: [
                                    widgetCariObat(),
                                    widgetListObats(),
                                  ])),
                          widgetKeranjangObatApotekerBody(),
                          widgetButtonSimpan()
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
    } else if (widget.visitId == null && aVLOs.length > 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Input Resep'),
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
                          TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "${widget.namaPembeli}",
                                fillColor: Colors.white,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Icon(Icons.person),
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
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                  title: Text(
                                    'Input Resep',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  children: [
                                    widgetCariObat(),
                                    widgetListObats(),
                                  ])),
                          widgetKeranjangObatApotekerBody(),
                          widgetButtonSimpan()
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
            title: Text('Input Resep'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: <Widget>[],
          ),
        ),
      );
    }
  }
}
