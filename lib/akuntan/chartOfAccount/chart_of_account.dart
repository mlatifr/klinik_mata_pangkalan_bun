import 'package:flutter/material.dart';

class ChartOfAccount extends StatefulWidget {
  const ChartOfAccount({Key key}) : super(key: key);

  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class _ChartOfAccountState extends State<ChartOfAccount> {
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
            body: Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(5),
                  },
                  children: [
                    TableRow(children: [
                      TableCell(child: Text('No')),
                      TableCell(child: Text('Nama'))
                    ]),
                    for (var i = 1; i < 11; i++)
                      TableRow(children: [
                        TableCell(child: Text('No $i')),
                        TableCell(child: Text('Nama $i'))
                      ]),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
