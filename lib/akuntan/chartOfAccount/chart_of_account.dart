import 'package:flutter/material.dart';

class ChartOfAccount extends StatefulWidget {
  const ChartOfAccount({Key key}) : super(key: key);

  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class AkunCoA {
  final int noCoA;
  final String namaCoA;
  bool isEnable;
  AkunCoA(
    this.noCoA,
    this.namaCoA,
    this.isEnable,
  );
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  List<TextEditingController> _editText =
      List.generate(5, (index) => TextEditingController());
  Color onEditColor = Colors.red;

  List<AkunCoA> listNamaAkun = [
    AkunCoA(001, 'kas1', false),
    AkunCoA(002, 'kas2', false),
    AkunCoA(003, 'kas3', false),
    AkunCoA(004, 'kas4', false),
    AkunCoA(005, 'kas5', false),
  ];
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
            body: DataTable(columns: [
              DataColumn(label: Text('Nomor')),
              DataColumn(label: Text('Nama')),
            ], rows: [
              for (var i = 0; i < listNamaAkun.length; i++)
                DataRow(cells: [
                  DataCell(
                    TextFormField(
                      initialValue: '${listNamaAkun[i].noCoA}',
                      enabled: listNamaAkun[i].isEnable,
                    ),
                    showEditIcon: true,
                    onTap: () {
                      setState(() {
                        listNamaAkun[i].isEnable = !listNamaAkun[i].isEnable;
                      });
                    },
                  ),
                  DataCell(
                    TextFormField(
                      // initialValue: '${listNamaAkun[i].namaCoA}',
                      controller: _editText[i],
                      enabled: listNamaAkun[i].isEnable,
                    ),
                    showEditIcon: true,
                    onTap: () {
                      setState(() {
                        listNamaAkun[i].isEnable = !listNamaAkun[i].isEnable;
                      });
                    },
                  ),
                ]),
            ])),
      ),
    );
  }
}
