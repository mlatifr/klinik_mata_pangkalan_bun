import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/nota/nota_tindakan/services/fetch_list_nota_tindakan.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../page_input_penjurnalan/views/akuntan_page_input_penjurnalan.dart';
import '../controller/list_nota_tindakan_controller.dart';

class AkuntanViewNotaTindakan extends StatefulWidget {
  const AkuntanViewNotaTindakan({Key key}) : super(key: key);

  @override
  State<AkuntanViewNotaTindakan> createState() => _AkuntanViewNotaTindakanState();
}

class _AkuntanViewNotaTindakanState extends State<AkuntanViewNotaTindakan> {
  var lj = ListNotaTindakanController();
  List _months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
  DateTime _bulanButton = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Daftar Nota Tindakan"),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            WidgetMonthPicker(context),
            SizedBox(
              height: 10,
            ),
            WidgetDataTable(),
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
            ).then((value) {
              setState(() {});
            });
          },
        ),
      )),
    );
  }

  SingleChildScrollView WidgetDataTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: fetchListNotaTindakan(_bulanButton),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done && snapshot.data.toString().contains('success')) {
              lj.GetListNotaTindakan(snapshot);
              return DataTable(headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]), columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Tgl')),
                DataColumn(label: Text('username')),
                DataColumn(label: Text('tindakan')),
                DataColumn(label: Text('harga')),
                DataColumn(label: Text('mata sis')),
              ], rows: [
                for (var i = 0; i < lj.listNotaTindakan.length; i++)
                  DataRow(cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text('${lj.listNotaTindakan[i].tglVisit.toString().substring(0, 11)}')),
                    DataCell(Text('${lj.listNotaTindakan[i].username}')),
                    DataCell(Text('${lj.listNotaTindakan[i].nama}')),
                    DataCell(Text('${lj.listNotaTindakan[i].harga}')),
                    DataCell(Text('${lj.listNotaTindakan[i].mtSisi}')),
                  ]),
              ]);
            } else {
              return Text('data error');
            }
          },
        ));
  }

  Row WidgetMonthPicker(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 10,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width, 50)),
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
              Text('${_months[_bulanButton.month - 1]} ${_bulanButton.year}'),
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
    ]);
  }
}
