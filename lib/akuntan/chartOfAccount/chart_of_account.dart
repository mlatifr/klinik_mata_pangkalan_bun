import 'package:flutter/material.dart';

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

  List<Color> onEditColor =
      List.generate(listNamaAkun.length, (index) => Colors.red);

  @override
  void initState() {
    super.initState();
    // AkuntanBacaDataCoa();
    // setState(() {});
    // print('done waiting: list total= ${listNamaAkun.length}');
    
    //tampil rendersetelah completed loade all data
    WidgetsBinding.instance.addPostFrameCallback((_) => AkuntanBacaDataCoa());
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
                              color: onEditColor[i],
                            ),
                            onPressed: () {
                              setState(() {
                                listNamaAkun[i].enableEditing =
                                    !listNamaAkun[i].enableEditing;
                                if (listNamaAkun[i].enableEditing) {
                                  onEditColor[i] = Colors.blue;
                                }
                                if (listNamaAkun[i].enableEditing == false) {
                                  onEditColor[i] = Colors.red;
                                }
                              });
                            }))
                      ]),
                  ]),
            )),
      ),
    );
  }
}
