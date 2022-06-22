import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_page_input_penjurnalan.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ListPenjurnalan extends StatefulWidget {
  @override
  State<ListPenjurnalan> createState() => _ListPenjurnalanState();
}

class _ListPenjurnalanState extends State<ListPenjurnalan> {
  DateTime _bulanButton = DateTime.now();
  List _months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('List Penjurnalan'),
        ),
        body: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                  onPressed: () {
                    showMonthYearPicker(
                      context: context,
                      initialDate: _bulanButton,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2023),
                    ).then((value) {
                      setState(() {
                        _bulanButton = value;
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text('${_months[_bulanButton.month - 1]}'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_today_sharp,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ],
                  ))
            ]),
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
            showModalBottomSheet(
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
