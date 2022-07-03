import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/controller/daftar_pegawai_controller.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/edit_pegawai_service.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/get_info_pegawai.dart';

import 'add_pegawai_view.dart';

class DaftarPegawai extends StatefulWidget {
  @override
  _DaftarPegawaiState createState() => _DaftarPegawaiState();
}

class _DaftarPegawaiState extends State<DaftarPegawai> {
  DaftarPegawaiController _pegawaiController = DaftarPegawaiController();
  List _listSatusButton = [];
  List<TextEditingController> _listTxtEditNama = [];
  List<TextEditingController> _listTxtEditTlp = [];
  List<TextEditingController> _listTxtEditUnitKerja = [];
  List<TextEditingController> _listTxtEditAlamat = [];
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
                            _listSatusButton.add(true);
                          }
                          if (_pegawaiController.listPegawai[i].status == 'non-aktif') {
                            _listSatusButton.add(false);
                          }
                          TextEditingController txtEditingNama = TextEditingController(text: _pegawaiController.listPegawai[i].nama);
                          _listTxtEditNama.add(txtEditingNama);
                          TextEditingController txtEditingTlp = TextEditingController(text: _pegawaiController.listPegawai[i].tlp);
                          _listTxtEditTlp.add(txtEditingTlp);
                          TextEditingController txtEditingUnitKerja = TextEditingController(text: _pegawaiController.listPegawai[i].unitKerja);
                          _listTxtEditUnitKerja.add(txtEditingUnitKerja);
                          TextEditingController txtEditingAlamat = TextEditingController(text: _pegawaiController.listPegawai[i].alamat);
                          _listTxtEditAlamat.add(txtEditingAlamat);
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
                                  // print('buka halaman edit ${_pegawaiController.listPegawai[i].nama}');
                                },
                                cells: [
                                  DataCell(Text('${_pegawaiController.listPegawai[i].nama}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].tlp}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].status}')),
                                  DataCell(Text('${_pegawaiController.listPegawai[i].unitKerja}')),
                                  DataCell(IconButton(
                                      onPressed: () {
                                        EditPegawaiModalBottom(context, i);
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

  Future<dynamic> EditPegawaiModalBottom(BuildContext context, int i) {
    return showModalBottomSheet(
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
                          // initialValue: _pegawaiController.listPegawai[i].nama,
                          controller: _listTxtEditNama[i],
                          decoration: InputDecoration(
                            hintText: 'Nama',
                          ),
                        ),
                        Align(alignment: Alignment.centerLeft, child: Text('Status')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Status Pegawai: ",
                              ),
                              _pegawaiController.listPegawai[i].status == 'aktif'
                                  ? TextSpan(
                                      text: "${_pegawaiController.listPegawai[i].status}",
                                      style: TextStyle(
                                          // decoration: TextDecoration.unsderline,
                                          decorationThickness: 2,
                                          decorationStyle: TextDecorationStyle.wavy))
                                  : TextSpan(
                                      text: "${_pegawaiController.listPegawai[i].status}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2,
                                          decorationStyle: TextDecorationStyle.wavy))
                            ], style: TextStyle(color: Colors.black))),
                            // Text('Status Pegawai: ${_pegawaiController.listPegawai[i].status} '),
                            Switch(
                                value: _listSatusButton[i],
                                onChanged: (bool value) {
                                  setState((() {
                                    _listSatusButton[i] = value;
                                    if (value == true) {
                                      _pegawaiController.listPegawai[i].status = 'aktif';
                                    } else {
                                      _pegawaiController.listPegawai[i].status = 'non-aktif';
                                    }
                                  }));
                                }),
                          ],
                        ),
                        Align(alignment: Alignment.centerLeft, child: Text('Telpon')),
                        TextFormField(
                          // initialValue: _pegawaiController.listPegawai[i].tlp,
                          controller: _listTxtEditTlp[i],
                          decoration: InputDecoration(
                            hintText: 'Tlp',
                          ),
                        ),
                        Align(alignment: Alignment.centerLeft, child: Text('Unit Kerja')),
                        TextFormField(
                          // initialValue: _pegawaiController.listPegawai[i].unitKerja,
                          controller: _listTxtEditUnitKerja[i],
                          decoration: InputDecoration(
                            hintText: 'Unit Kerja',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  String _status = '';
                                  if (_listSatusButton[i]) {
                                    _status = 'aktif';
                                  } else {
                                    _status = 'non-aktif';
                                  }
                                  PostEditPegawai(_pegawaiController.listPegawai[i].id, _status, _listTxtEditNama[i].text,
                                      _listTxtEditUnitKerja[i].text, _listTxtEditTlp[i].text, _listTxtEditAlamat[i].text);
                                },
                                child: Text('Simpan')),
                            SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Batal'),
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                            )
                          ],
                        )
                      ],
                    )));
          });
        });
  }
}
