import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/akuntan/nota/nota_obat/controller/list_nota_obat_controller.dart';
import 'package:flutter_application_1/akuntan/nota/nota_obat/services/fetch_list_nota_obat.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../page_input_penjurnalan/views/akuntan_page_input_penjurnalan.dart';

class AkuntanViewNotaObat extends StatefulWidget {
  const AkuntanViewNotaObat({Key key}) : super(key: key);

  @override
  State<AkuntanViewNotaObat> createState() => _AkuntanViewNotaObatState();
}

class _AkuntanViewNotaObatState extends State<AkuntanViewNotaObat> {
  var lj = ListNotaObatController();
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
            title: Text("Daftar Nota Obat"),
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
              // if(listPenjurnalan!=null)
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
        ),
      ),
    );
  }

  SingleChildScrollView WidgetDataTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: fetchListNotaObat(_bulanButton),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done && snapshot.data.toString().contains('success')) {
              lj.GetListNotaObat(snapshot);
              return DataTable(headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]), columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Tgl')),
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('stok')),
                DataColumn(label: Text('terjual')),
                DataColumn(label: Text('hargaJual')),
                DataColumn(label: Text('hargaBeli')),
                DataColumn(label: Text('statusOrder')),
              ], rows: [
                for (var i = 0; i < lj.listNotaObat.length; i++)
                  if (lj.listNotaObat[i].statusOrder == 'pemesanan')
                    DataRow(cells: [
                      DataCell(Text('${i + 1}')),
                      DataCell(Text('${lj.listNotaObat[i].tanggal.toString().substring(0, 11)}')),
                      DataCell(Text('${lj.listNotaObat[i].nama}')),
                      DataCell(Text('${lj.listNotaObat[i].stok}')),
                      DataCell(Text('${lj.listNotaObat[i].terjual}')),
                      DataCell(Text('${lj.listNotaObat[i].hargaJual}')),
                      DataCell(Text('${lj.listNotaObat[i].hargaBeli}')),
                      DataCell(Text('${lj.listNotaObat[i].statusOrder}', style: TextStyle(backgroundColor: Colors.redAccent, color: Colors.white))),
                    ]),
                for (var i = 0; i < lj.listNotaObat.length; i++)
                  if (lj.listNotaObat[i].statusOrder == 'penjualan')
                    DataRow(cells: [
                      DataCell(Text('${i + 1}')),
                      DataCell(Text('${lj.listNotaObat[i].tanggal.toString().substring(0, 11)}')),
                      DataCell(Text('${lj.listNotaObat[i].nama}')),
                      DataCell(Text('${lj.listNotaObat[i].stok}')),
                      DataCell(Text('${lj.listNotaObat[i].terjual}')),
                      DataCell(Text('${lj.listNotaObat[i].hargaJual}')),
                      DataCell(Text('${lj.listNotaObat[i].hargaBeli}')),
                      DataCell(Text(
                        '${lj.listNotaObat[i].statusOrder}',
                        style: TextStyle(backgroundColor: Colors.green, color: Colors.white),
                      )),
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
