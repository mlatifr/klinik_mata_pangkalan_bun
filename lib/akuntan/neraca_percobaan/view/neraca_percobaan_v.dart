import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../controller/list_neraca_percobaan_controller.dart';
import '../services/fetch_list_neraca_percobaan.dart';

class NeracaPercobaanView extends StatefulWidget {
  @override
  State<NeracaPercobaanView> createState() => _NeracaPercobaanViewState();
}

class _NeracaPercobaanViewState extends State<NeracaPercobaanView> {
  var lj = ListNeracaPercobaanController();
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
          title: Text("Neraca Percobaan"),
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
      )),
    );
  }

  SingleChildScrollView WidgetDataTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: fetchListNeracaPercobaan(_bulanButton),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done && snapshot.data.toString().contains('success')) {
              lj.GetListNeracaPercobaan(snapshot);
              return DataTable(headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]), columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('No Akun')),
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Debet')),
                DataColumn(label: Text('Kredit')),
              ], rows: [
                for (var i = 0; i < lj.listNeracaPercobaan.length; i++)
                  DataRow(cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text('${lj.listNeracaPercobaan[i].tglCatat.toString().substring(0, 11)}')),
                    DataCell(Text('${lj.listNeracaPercobaan[i].no}')),
                    DataCell(Text('${lj.listNeracaPercobaan[i].nama}')),
                    DataCell(Text('${lj.listNeracaPercobaan[i].debet}')),
                    DataCell(Text('${lj.listNeracaPercobaan[i].kredit}')),
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
