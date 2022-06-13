import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/controller/daftar_pegawai_controller.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/get_info_pegawai.dart';

import 'modalBottomAddPegawai.dart';

class DaftarPegawai extends StatefulWidget {
  @override
  _DaftarPegawaiState createState() => _DaftarPegawaiState();
}

class _DaftarPegawaiState extends State<DaftarPegawai> {
  DaftarPegawaiController _pegawaiController = DaftarPegawaiController();
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
          body: SingleChildScrollView(
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
                    return DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue[100]),
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Telepon')),
                        ],
                        rows: [
                          for (var i = 0;
                              i < _pegawaiController.listPegawai.length;
                              i++)
                            DataRow(cells: [
                              DataCell(Text(
                                  '${_pegawaiController.listPegawai[i].nama}')),
                              DataCell(Text(
                                  '${_pegawaiController.listPegawai[i].tlp}')),
                            ]),
                        ]);
                  } else {
                    return Text('data waiting');
                  }
                }),
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
