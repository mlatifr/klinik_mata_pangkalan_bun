import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/model_listAkun.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/tambah_akun/tambah_akunCoA.dart';

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
                      listNamaAkun.clear();
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
                                                Colors.red;
                                          });
                                        }
                                        if (listNamaAkun[i].enableEditing ==
                                            false) {
                                          print(
                                              "listNamaAkun[$i].enableEditing: ${listNamaAkun[i].enableEditing}"
                                              "\n onEditColor[$i] ${listNamaAkun[i].editColor}");
                                          setState(() {
                                            listNamaAkun[i].editColor =
                                                Colors.blue;
                                          });
                                        }
                                      }))
                                ]),
                            ]),
                      );
                    } else {
                      return Text('data waiting');
                    }
                  })),
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {},
          //   label: Text('Tambah Akun'),
          //   icon: Icon(Icons.add),
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => TambahAkunCoA()));
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext ctx) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: 'No Akun',
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: 'Nama Akun',
                            ),
                          ),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(ctx),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
