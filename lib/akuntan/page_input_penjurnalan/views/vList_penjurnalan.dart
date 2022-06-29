import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_page_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/controler/list_penjurnalan_controller.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/services/fetchListJurnal.dart';
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
  var lj = ListPenjurnalanController();
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                  onPressed: () {
                    showMonthYearPicker(
                      context: context,
                      initialDate: _bulanButton,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        if (_bulanButton != null) _bulanButton = value;
                        if (_bulanButton == null) _bulanButton = DateTime.now();
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          '${_months[_bulanButton.month - 1]} ${_bulanButton.year}'),
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
            SizedBox(
              height: 10,
            ),
            // if(listPenjurnalan!=null)
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: fetchListJurnal(_bulanButton),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data.toString().contains('success')) {
                      lj.GetListJurnal(snapshot);
                      return DataTable(
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
                            for (var i = 0; i < lj.listPenjurnalan.length; i++)
                              DataRow(cells: [
                                DataCell(Text('${i + 1}')),
                                DataCell(Text(
                                    '${lj.listPenjurnalan[i].tglCatat.toString().substring(0, 11)}')),
                                DataCell(Text('${lj.listPenjurnalan[i].nama}')),
                                DataCell(
                                    Text('${lj.listPenjurnalan[i].noAkun}')),
                                if (lj.listPenjurnalan[i].debet != 0)
                                  DataCell(Text(
                                    'db ${lj.listPenjurnalan[i].debet}',
                                    // style: TextStyle(
                                    //     backgroundColor: Colors.blue,
                                    //     color: Colors.white),
                                  )),
                                if (lj.listPenjurnalan[i].kredit != 0)
                                  DataCell(Text(
                                    'kr ${lj.listPenjurnalan[i].kredit}',
                                    // style: TextStyle(
                                    //     backgroundColor: Colors.red,
                                    //     color: Colors.white),
                                  )),
                                DataCell(Text(
                                    '${lj.listPenjurnalan[i].ket_transaksi}')),
                              ]),
                          ]);
                    } else {
                      return Text('data error');
                    }
                  },
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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
