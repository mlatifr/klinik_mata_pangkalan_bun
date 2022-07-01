import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/controller/daftar_pegawai_controller.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/get_info_pegawai.dart';

import 'add_pegawai_view.dart';

class DaftarPegawai extends StatefulWidget {
  @override
  _DaftarPegawaiState createState() => _DaftarPegawaiState();
}

class _DaftarPegawaiState extends State<DaftarPegawai> {
  DaftarPegawaiController _pegawaiController = DaftarPegawaiController();
  List listSatusButton = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Daftar Pegawai')),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                    future: FetchInfoPegawai(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        // print((snapshot.data.runtimeType.toString()));
                        _pegawaiController.ConvertJsonListPegawai(snapshot);
                        for (var i = 0; i < _pegawaiController.listPegawai.length; i++) {
                          if (_pegawaiController.listPegawai[i].status == 'aktif') {
                            listSatusButton.add(true);
                          }
                          if (_pegawaiController.listPegawai[i].status == 'non-aktif') {
                            listSatusButton.add(false);
                          }
                        }
                        return DataTable(headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]), columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Telepon')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Unit\nKerja')),
                          DataColumn(label: Text('Edit')),
                        ], rows: [
                          for (var i = 0; i < _pegawaiController.listPegawai.length; i++)
                            DataRow(
                                onLongPress: () {
                                  print('buka halaman edit ${_pegawaiController.listPegawai[i].nama}');
                                },
                                cells: [
                                  DataCell(Text('${_pegawaiController.listPegawai[i].nama}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].tlp}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].status}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].unitKerja}')),
                                  DataCell(IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                return SafeArea(
                                                    child: Container(
                                                        padding: EdgeInsets.all(20),
                                                        height: MediaQuery.of(context).size.height + (MediaQuery.of(context).size.height * 0.2),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Align(alignment: Alignment.centerLeft, child: Text('Nama')),
                                                            TextFormField(
                                                              decoration: InputDecoration(
                                                                hintText: 'Nama',
                                                              ),
                                                            ),
                                                            Align(alignment: Alignment.centerLeft, child: Text('Status')),
                                                            Row(
                                                              children: [
                                                                Switch(
                                                                    value: listSatusButton[i],
                                                                    onChanged: (bool value) {
                                                                      setState((() {
                                                                        listSatusButton[i] = value;
                                                                      }));
                                                                      for (var element in listSatusButton) {
                                                                        print(element);
                                                                      }
                                                                    }),
                                                              ],
                                                            ),
                                                            Align(alignment: Alignment.centerLeft, child: Text('Telpon')),
                                                            TextFormField(
                                                              decoration: InputDecoration(
                                                                hintText: 'Tlp',
                                                              ),
                                                            ),
                                                            Align(alignment: Alignment.centerLeft, child: Text('Unit Kerja')),
                                                            TextFormField(
                                                              decoration: InputDecoration(
                                                                hintText: 'Unit Kerja',
                                                              ),
                                                            ),
                                                          ],
                                                        )));
                                              });
                                            });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ))),
                                  // if (i >= 5)
                                  //   DataCell(Text(
                                  //     'Aktif',
                                  //     style: TextStyle(
                                  //         backgroundColor: Colors.blue[200]),
                                  //   )),
                                  // if (i < 5) DataCell(Text('Non-Aktif')),
                                  // if (i >= 5) DataCell(Text('Admin')),
                                  // if (i < 5) DataCell(Text('Perawat')),
                                ]),
                        ]);
                      } else {
                        return Text('data waiting');
                      }
                    }),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AddPegawaiModalBottom(context, _pegawaiController).then((value) {
                setState(() {});
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
