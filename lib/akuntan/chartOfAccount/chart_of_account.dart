import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/model_listAkun.dart';

import 'get_listCoA.dart';

class ChartOfAccount extends StatefulWidget {
  const ChartOfAccount({Key key}) : super(key: key);

  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  @override
  void initState() {
    super.initState();
  }

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
                      return SingleChildScrollView(
                        child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue[100]),
                            columns: [
                              DataColumn(label: Text('Nomor')),
                              DataColumn(label: Text('Nama')),
                            ],
                            rows: [
                              for (var i = 0; i < listNamaAkun.length; i++)
                                DataRow(cells: [
                                  DataCell(
                                    TextFormField(
                                      initialValue: '${listNamaAkun[i].no}',
                                      enabled: false,
                                    ),
                                  ),
                                  DataCell(
                                    TextFormField(
                                      initialValue: '${listNamaAkun[i].nama}',
                                      enabled: false,
                                      onChanged: (value) {
                                        listNamaAkun[i].nama = value;
                                        print("${listNamaAkun[i].nama}");
                                      },
                                    ),
                                  ),
                                ]),
                            ]),
                      );
                    } else {
                      return Text('data waiting');
                    }
                  })),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await ModalBottomAddCoA(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> ModalBottomAddCoA(BuildContext context) {
    TextEditingController _noAkun = TextEditingController();
    TextEditingController _namaAkun = TextEditingController();
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          // color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _noAkun,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'No Akun',
                  ),
                ),
                TextFormField(
                  controller: _namaAkun,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Nama Akun',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text('Tambah'),
                      onPressed: () {
                        setState(() {
                          listNamaAkun.add(
                            DataCoA(
                                nama: _namaAkun.text,
                                no: int.parse(_noAkun.text),
                                enableEditing: false,
                                editColor: Colors.blue),
                          );
                        });
                        for (var item in listNamaAkun) {
                          print(item.nama);
                        }
                        Navigator.pop(ctx);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Batal'),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
