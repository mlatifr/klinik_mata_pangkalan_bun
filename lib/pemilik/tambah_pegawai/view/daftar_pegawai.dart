import 'package:flutter/material.dart';

class DaftarPegawai extends StatelessWidget {
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
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.blue[100]),
                columns: [
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Telepone')),
                ],
                rows: [
                  for (var i = 0; i < 10; i++)
                    DataRow(cells: [
                      DataCell(Text('Pegawai ${i + 1}')),
                      DataCell(Text('081$i-504$i-02$i')),
                    ]),
                ]),
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
