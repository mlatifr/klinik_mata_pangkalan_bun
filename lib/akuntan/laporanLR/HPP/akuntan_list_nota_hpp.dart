import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/HPP/fetch_hpp_obat.dart';
import 'package:intl/intl.dart';

import 'akuntan_detail_hpp.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetListNotaHpp extends StatefulWidget {
  var tgl_transaksi;
  WidgetListNotaHpp({Key key, this.tgl_transaksi}) : super(key: key);

  @override
  _WidgetListNotaHppState createState() => _WidgetListNotaHppState();
}

class _WidgetListNotaHppState extends State<WidgetListNotaHpp> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataDaftarNotaHpp(tgl) {
    listNotaHppObats.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVListNotaHppObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVListNotaHpp notaHPP = AkuntanVListNotaHpp.fromJson(i);
        listNotaHppObats.add(notaHPP);
      }
      setState(() {
        widgetListObatNota();
        // print('listNotaPjnlObat.length ${listHppObats.length}');
      });
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObatNota() {
    if (listNotaHppObats.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listNotaHppObats.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        // width: 3.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WidgetDetailNotaHpp(
                              nota_id: listNotaHppObats[index].no_nota)));
                    },
                    title: Center(
                      child: Text('Nota ${listNotaHppObats[index].no_nota}' +
                          ' | Rp ${numberFormatRp.format(listNotaHppObats[index].total_harga)}'),
                    ),
                  ),
                ));
          });
    } else {
      return Column(
        children: [
          ListTile(title: Center(child: Text('${widget.tgl_transaksi}'))),
        ],
      );
    }
  }

  @override
  void initState() {
    AkunanBacaDataDaftarNotaHpp(widget.tgl_transaksi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Center(
              child: Text(
                "Daftar Nota Obat\n${widget.tgl_transaksi}",
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: [widgetListObatNota()],
          )),
    );
  }
}
