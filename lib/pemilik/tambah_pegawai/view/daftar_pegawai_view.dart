import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/controller/daftar_pegawai_controller.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/get_info_pegawai.dart';

class DaftarPegawai extends StatefulWidget {
  @override
  _DaftarPegawaiState createState() => _DaftarPegawaiState();
}

class _DaftarPegawaiState extends State<DaftarPegawai> {
  DaftarPegawaiController _pgwCtrl = DaftarPegawaiController();
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
                    _pgwCtrl.ConvertJsonListPegawai(snapshot);
                    return DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue[100]),
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Telepone')),
                        ],
                        rows: [
                          for (var i = 0; i < _pgwCtrl.listPegawai.length; i++)
                            DataRow(cells: [
                              DataCell(Text('${_pgwCtrl.listPegawai[i].nama}')),
                              DataCell(Text('${_pgwCtrl.listPegawai[i].tlp}')),
                            ]),
                        ]);
                  } else {
                    return Text('data waiting');
                  }
                }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
