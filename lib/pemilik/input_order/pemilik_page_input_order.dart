import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/apoteker/apt_get_resep_pasien_detail.dart';
import 'package:flutter_application_1/pemilik/pemilik_fetch/pemilik_send_input_order.dart';


DateTime date;

class PemilikInputOrderObat extends StatefulWidget {
  final pmlkId, namaPasien, visitId;

  const PemilikInputOrderObat(
      {Key key, this.pmlkId, this.namaPasien, this.visitId})
      : super(key: key);

  @override
  _PemilikInputOrderObatState createState() => _PemilikInputOrderObatState();
}

class _PemilikInputOrderObatState extends State<PemilikInputOrderObat> {
  // ignore: non_constant_identifier_names
  PemilikBacaDataVListObat(pNamaObat) {
    aVLOs.clear();
    Future<String> data = fetchDataPemilikVListObat(pNamaObat);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      print(json);
      if (json['result'].toString().contains('success')) {
        for (var i in json['data']) {
          ApotekerrVListObat avlo = ApotekerrVListObat.fromJson(i);
          aVLOs.add(avlo);
        }
      }
      setState(() {
        widgetListSuggestObats();
      });
      print('PemilikBacaDataVListObat aVLOs.length: ${aVLOs.length} ');
    });
  }

  Widget widgetCariObat() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariObat,
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

  TextEditingController controllerObatNama = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerHargaBeliPerItem = TextEditingController();
  TextEditingController controllerBiayaOngkir = TextEditingController();
  TextEditingController controllerHPP = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile
  // (jumlah * Hrg Item)- ongkir
  Widget widgetInputObatBaru() {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Input Order',
          textAlign: TextAlign.center,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerObatNama,
              onChanged: (value) {
                PemilikBacaDataVListObat(value);
                print('aVLOs.length ${aVLOs.length}');
                suggestNamaObat = true;
              },
              decoration: InputDecoration(
                labelText: "Nama Obat",
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
        //isi list view

        widgetListSuggestObats(),
        Row(
          children: [
            Flexible(
              flex: 1,
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
                      var hpp = 0, jumlah = 0, hrgItem = 0, ongKir = 0;
                      if (value.isNotEmpty) {
                        jumlah = int.parse(value);
                      }
                      if (controllerHargaBeliPerItem.text != '') {
                        hrgItem = int.parse(controllerHargaBeliPerItem.text);
                      }
                      if (controllerBiayaOngkir.text != '') {
                        ongKir = int.parse(controllerBiayaOngkir.text);
                      }
                      print('jmlh $jumlah | item $hrgItem | ongkir $ongKir');
                      hpp = (jumlah * hrgItem) - ongKir;
                      setState(() {
                        controllerHPP.text = hpp.toString();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Jumlah",
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
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    enabled: true,
                    controller: controllerHargaBeliPerItem,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      var hpp = 0, jumlah = 0, hrgItem = 0, ongKir = 0;
                      if (controllerJumlah.text != '') {
                        jumlah = int.parse(controllerJumlah.text);
                      }
                      if (value.isNotEmpty) {
                        hrgItem = int.parse(value);
                      }
                      if (controllerBiayaOngkir.text != '') {
                        ongKir = int.parse(controllerBiayaOngkir.text);
                      }
                      print('jmlh $jumlah | item $hrgItem | ongkir $ongKir');
                      hpp = (jumlah * hrgItem) - ongKir;
                      setState(() {
                        controllerHPP.text = hpp.toString();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Harga Item",
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
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    enabled: true,
                    controller: controllerBiayaOngkir,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      var hpp = 0, jumlah = 0, hrgItem = 0, ongKir = 0;
                      if (controllerJumlah.text != '') {
                        jumlah = int.parse(controllerJumlah.text);
                      }
                      if (controllerHargaBeliPerItem.text != '') {
                        hrgItem = int.parse(controllerHargaBeliPerItem.text);
                      }
                      if (value.isNotEmpty) {
                        ongKir = int.parse(value);
                      }
                      print('jmlh $jumlah | item $hrgItem | ongkir $ongKir');
                      hpp = (jumlah * hrgItem) - ongKir;
                      setState(() {
                        controllerHPP.text = hpp.toString();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Ongkir",
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
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    enabled: false,
                    controller: controllerHPP,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        value = 0.toString();
                        print('$value');
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Harga Jual",
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
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              PemilikInputResepList selectedObat = PemilikInputResepList(
                  obatNama: controllerObatNama.text,
                  jumlah_order: controllerJumlah.text,
                  harga_beli: controllerHargaBeliPerItem.text);
              ListKeranjangObat.add(selectedObat);
              setState(() {
                ListHargaJual.clear();
                // print("widgetKeranjangObatBodyPemilik: ${ListInputResep.length}");
                for (var i = 0; i < ListKeranjangObat.length; i++) {
                  TextEditingController txtHrgJual = TextEditingController();
                  txtHrgJual.text = (i - i).toString();
                  ListHargaJual.add(txtHrgJual);
                }
                widgetKeranjangObatBodyPemilik();
                controllerObatNama.text = '';
                controllerJumlah.text = '';
                controllerHargaBeliPerItem.text = '';
                controllerBiayaOngkir.text = '';
                controllerHPP.text = '';
              });
            },
            child: Text('tambah'),
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
                            controllerJumlah.text = "";
                            controllerHargaBeliPerItem.text = "";
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
                                        controller: controllerHargaBeliPerItem,
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
                                          harga_beli:
                                              controllerHargaBeliPerItem.text);
                                  ListKeranjangObat.add(selectedObat);
                                  setState(() {
                                    controllerJumlah.text = "";
                                    controllerHargaBeliPerItem.text = "";
                                    widgetKeranjangObatBodyPemilik();
                                  });
                                  print(ListKeranjangObat.length);
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
    } else
      return Container();
  }

  var suggestNamaObat = true;
  // ignore: missing_return
  Widget widgetListSuggestObats() {
    if (suggestNamaObat == true && controllerObatNama.text.length > 0) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: Column(
          children: [
            Text(
              'Saran Obat:',
            ),
            ListView.builder(
                key: Key(
                    'builder ${selected.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: aVLOs.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: ListTile(
                        title: Text('${aVLOs[index].obatNama}'),
                        onTap: () {
                          controllerObatNama.text = aVLOs[index].obatNama;
                          suggestNamaObat = false;
                          setState(() {
                            widgetListSuggestObats();
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                          border:
                              Border(left: BorderSide(), right: BorderSide())));
                }),
          ],
        ),
      );
    } else
      return Container();
  }

  Widget widgetKeranjangObatHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Table(
          columnWidths: {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(3),
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
                'Jmlh',
                textAlign: TextAlign.center,
              ),
              Text(
                'Hg Item',
                textAlign: TextAlign.center,
              ),
              Text(
                'Hg Jual',
                textAlign: TextAlign.center,
              ),
              Text(
                '',
                textAlign: TextAlign.center,
              ),
            ]),
          ]),
    );
  }

  Widget widgetKeranjangObatBodyPemilik() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ListKeranjangObat.length,
          itemBuilder: (context, index) {
            return Table(
                columnWidths: {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(3),
                  3: FlexColumnWidth(3),
                },
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
                          style: TextStyle(fontSize: 14),
                          enabled: true,
                          controller: ListHargaJual[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            print(
                                'kerangjang value ${ListHargaJual[index].text}');
                          },

                          // onChanged: (value) {
                          //   ListKeranjangObat[index].harga_jual =
                          //       ListHargaJual[index].text;
                          //   for (var item in ListKeranjangObat) {
                          //     print(item.obatNama + '\n' + item.harga_jual);
                          //   }
                          // },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: BorderSide(
                            //     color: Colors.blue,
                            //   ),
                            // ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: BorderSide(
                            //     color: Colors.blue,
                            //   ),
                            // ),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        ListKeranjangObat.removeAt(index);
                        setState(() {
                          widgetKeranjangObatBodyPemilik();
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ]),
                ]);
          }),
    );
  }

  Widget widgetButtonSimpan() {
    var textBtnSimpan = 'SIMPAN';
    return ElevatedButton(
        onPressed: () {
          if (ListKeranjangObat.isNotEmpty) {
            // send data tgl and user pemesan to db
            // then simpan hasil id order ke aplikasi
            // then simpan list obat dg id_order
            print('${widget.pmlkId} | ${date.toString().substring(0, 10)}');
            idOrder = '';
            fetchDataIdOrderId(widget.pmlkId, date.toString().substring(0, 10))
                .then((value) {
              Map json = jsonDecode(value);
              idOrder = json['order_obat_id'].toString();
              for (var i = 0; i < ListKeranjangObat.length; i++) {
                //fetch send kirim data krjg obat
                fetchDataPemilikSendKrjgObat(
                        idOrder,
                        ListKeranjangObat[i].jumlah_order,
                        ListKeranjangObat[i].obatNama,
                        ListKeranjangObat[i].harga_beli,
                        ListKeranjangObat[i].harga_jual,
                        'pemesanan')
                    .then((value) {
                  print('btn simpan $value');
                  // ListKeranjangObat.clear();
                  if (i + 1 == ListKeranjangObat.length) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Pemesana Berhasil',
                          style: TextStyle(fontSize: 14),
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                ListKeranjangObat.clear();
                                print('last index $i ' +
                                    'length ${ListKeranjangObat.length}');
                                setState(() {
                                  widgetKeranjangObatBodyPemilik();
                                });
                                Navigator.pop(context);
                              },
                              child: Text('ok')),
                        ],
                      ),
                    );
                  }
                });
              }
            });
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
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
        child: Text('$textBtnSimpan'));
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    controllerCariObat.clear();
    PemilikBacaDataVListObat(controllerCariObat.text);
    ListInputResep.clear();
    suggestNamaObat = false;
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
              ListKeranjangObat.clear();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  color: Colors.green[50],
                  child: Column(
                    children: [
                      widgetInputObatBaru(),
                      // ExpansionTile(
                      //     title: Text(
                      //       'Stok Obat',
                      //       textAlign: TextAlign.center,
                      //     ),
                      //     children: [
                      //       widgetCariObat(),
                      //       widgetListObats(),
                      //     ]),
                      ExpansionTile(
                        title: Text(
                          'Keranjang Obat',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Persentase Profit')),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        enabled: true,
                                        onChanged: (value) {
                                          if (value == "") {
                                            value = 0.toString();
                                          }
                                          for (var i = 0;
                                              i < ListHargaJual.length;
                                              i++) {
                                            //persamaan= h.beli + (h.beli * value/100)
                                            var persen = int.parse(value);
                                            var hBeli = int.parse(
                                                ListKeranjangObat[i]
                                                    .harga_beli);
                                            var rumus =
                                                hBeli + (hBeli * persen / 100);
                                            ListHargaJual[i].text = (rumus)
                                                .toString()
                                                .substring(
                                                    0,
                                                    rumus.toString().length -
                                                        2);
                                            ListKeranjangObat[i].harga_jual =
                                                ListHargaJual[i].text;
                                            print(ListHargaJual[i].text);
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          labelText: '%',
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
                              ],
                            ),
                          ),
                          widgetKeranjangObatHeader(),
                          widgetKeranjangObatBodyPemilik(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widgetButtonSimpan()
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
