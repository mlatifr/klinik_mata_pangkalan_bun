import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/model_listAkun.dart';

import 'get_listCoA.dart';

class ChartOfAccount extends StatefulWidget {
  const ChartOfAccount({Key key}) : super(key: key);

  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  // List<TextEditingController> listEditNamaCoA =
  //     List.generate(listNamaAkun.length, (index) {
  //   TextEditingController();
  // });
  // List<TextEditingController> listEditText = [
  //   TextEditingController(text: 'first')
  // ];
  Color onEditColor;

  // @override
  // void initState() {
  //   super.initState();
  //   AkuntanBacaDataCoa().then((value) {
  //     setState(() {
  //       _listNamaAkun = listNamaAkun;
  //       onEditColor =
  //           List.generate(_listNamaAkun.length, (index) => Colors.red);
  //     });
  //     print('done waiting: list total= ${_listNamaAkun.length}');
  //   });

  //   // //tampil rendersetelah completed loade all data
  //   // WidgetsBinding.instance.addPostFrameCallback((_) => AkuntanBacaDataCoa());
  // }
  @override
  void initState() {
    super.initState();
  }
  // void waitingReadListCoA() async {
  //   await Future.wait([
  //     AkuntanBacaDataCoa().then((value) {
  //       print('done waiting: list total= ${listNamaAkun.length}');
  //       setState(() {});
  //     })
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Chart Of Account')),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
                child: FutureBuilder(
                    future: fetchAkuntanCoA(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var _hasil = snapshot.data['data'];

                        // print("snapshot: ${snapshot.data}");
                        for (var i in _hasil) {
                          listNamaAkun.add(DataCoA(
                              enableEditing: false,
                              id: i['id'],
                              no: i['no'],
                              nama: i['nama'],
                              editColor: Colors.blue));
                        }

                        return SingleChildScrollView(
                          child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue[100]),
                              columns: [
                                DataColumn(label: Text('Nomor')),
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('Edit')),
                              ],
                              rows: [
                                for (var i = 0; i < listNamaAkun.length; i++)
                                  DataRow(cells: [
                                    DataCell(
                                      TextFormField(
                                        initialValue: '${listNamaAkun[i].no}',
                                        enabled: listNamaAkun[i].enableEditing,
                                      ),
                                    ),
                                    DataCell(
                                      TextFormField(
                                        initialValue: '${listNamaAkun[i].nama}',
                                        // controller: listEditNamaCoA[i],
                                        enabled: listNamaAkun[i].enableEditing,
                                        onChanged: (value) {
                                          listNamaAkun[i].nama = value;
                                          print("${listNamaAkun[i].nama}");
                                        },
                                      ),
                                    ),
                                    DataCell(IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: listNamaAkun[i].editColor,
                                        ),
                                        onPressed: () {
                                          listNamaAkun[i].enableEditing =
                                              !listNamaAkun[i].enableEditing;

                                          if (listNamaAkun[i].enableEditing) {
                                            print(
                                                "listNamaAkun[$i].enableEditing: ${listNamaAkun[i].enableEditing}"
                                                "\n onEditColor[$i] ${listNamaAkun[i].editColor}");
                                            setState(() {
                                              listNamaAkun[i].editColor =
                                                  Colors.blue;
                                            });
                                          }
                                          if (listNamaAkun[i].enableEditing ==
                                              false) {
                                            print(
                                                "listNamaAkun[$i].enableEditing: ${listNamaAkun[i].enableEditing}"
                                                "\n onEditColor[$i] ${listNamaAkun[i].editColor}");
                                            setState(() {
                                              listNamaAkun[i].editColor =
                                                  Colors.red[200];
                                            });
                                          }
                                        }))
                                  ]),
                              ]),
                        );
                      } else {
                        return Text('data waiting');
                      }
                    }))),
      ),
    );
  }
}
