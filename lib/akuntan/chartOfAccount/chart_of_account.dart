import 'package:flutter/material.dart';

class ChartOfAccount extends StatefulWidget {
  const ChartOfAccount({Key key}) : super(key: key);

  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class AkunCoA {
  int noCoA;
  String namaCoA;
  bool isEnablenoCoA;
  bool isEnablenamaCoA;
  AkunCoA(this.noCoA, this.namaCoA, this.isEnablenoCoA, this.isEnablenamaCoA);
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  List<AkunCoA> listNamaAkun = [
    AkunCoA(001, 'kas1', false, false),
    AkunCoA(002, 'kas2', false, false),
    AkunCoA(003, 'kas3', false, false),
    AkunCoA(004, 'kas4', false, false),
    AkunCoA(005, 'kas5', false, false),
    AkunCoA(006, 'kas6', false, false),
    AkunCoA(007, 'kas7', false, false),
    AkunCoA(008, 'kas8', false, false),
    AkunCoA(009, 'kas9', false, false),
    AkunCoA(010, 'kas10', false, false),
    AkunCoA(011, 'kas11', false, false),
    AkunCoA(012, 'kas12', false, false),
    AkunCoA(013, 'kas13', false, false),
  ];
  List<TextEditingController> listEditNamaCoA = List.generate(13, (index) {
    TextEditingController();
  });
  // List<TextEditingController> listEditText = [
  //   TextEditingController(text: 'first')
  // ];

  List<Color> onEditColor = List.generate(13, (index) => Colors.red);

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
                            initialValue: '${listNamaAkun[i].noCoA}',
                            enabled: listNamaAkun[i].isEnablenoCoA,
                          ),
                        ),
                        DataCell(
                          TextFormField(
                            initialValue: '${listNamaAkun[i].namaCoA}',
                            // controller: listEditNamaCoA[i],
                            enabled: listNamaAkun[i].isEnablenamaCoA,
                            onChanged: (value) {
                              listNamaAkun[i].namaCoA = value;
                              print("${listNamaAkun[i].namaCoA}");
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
                                listNamaAkun[i].isEnablenamaCoA =
                                    !listNamaAkun[i].isEnablenamaCoA;
                                if (listNamaAkun[i].isEnablenamaCoA) {
                                  onEditColor[i] = Colors.blue;
                                }
                                if (listNamaAkun[i].isEnablenamaCoA == false) {
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
