import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_page_input_penjurnalan.dart';

class ListPenjurnalan extends StatefulWidget {
  @override
  State<ListPenjurnalan> createState() => _ListPenjurnalanState();
}

class _ListPenjurnalanState extends State<ListPenjurnalan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('List Penjurnalan'),
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blue[100]),
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Tgl')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('No\nAkun')),
                      DataColumn(label: Text('Debet/\nKredit')),
                      DataColumn(label: Text('Keterangan')),
                    ],
                    rows: [
                      for (var i = 0; i < 30; i++)
                        DataRow(cells: [
                          DataCell(Text('${i}')),
                          DataCell(Text('Tgl 1${i}-05-2022')),
                          DataCell(Text('Nama ${i}')),
                          DataCell(Text('10${i}')),
                          if (i.isOdd)
                            DataCell(Text(
                              'debet',
                              style: TextStyle(
                                  backgroundColor: Colors.blue,
                                  color: Colors.white),
                            )),
                          if (i.isEven)
                            DataCell(Text(
                              'kredit',
                              style: TextStyle(
                                  backgroundColor: Colors.red,
                                  color: Colors.white),
                            )),
                          DataCell(Text('Membeli Obat X Batch ${i}')),
                        ]),
                    ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return Scaffold(body: AkuntanInputPenjurnalan());
              },
            );
          },
        ),
      ),
    );
  }
}
