import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/akuntan_detail_tindakan.dart';
import 'package:flutter_application_1/akuntan/laporanLR/tindakan/fetch_tindakan.dart';
import 'package:intl/intl.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetListNotaTindakan extends StatefulWidget {
  var tgl_transaksi;
  WidgetListNotaTindakan({Key key, this.tgl_transaksi}) : super(key: key);

  @override
  _WidgetListNotaTindakanState createState() => _WidgetListNotaTindakanState();
}

class _WidgetListNotaTindakanState extends State<WidgetListNotaTindakan> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataDaftarNotaTindakan(tgl) {
    listNotaTindakan.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVListNotaTindakan(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        ListNotaTindakan notaHPP = ListNotaTindakan.fromJson(i);
        listNotaTindakan.add(notaHPP);
      }
      setState(() {
        widgetListNotaTindakan();
        // print('listNotaPjnlObat.length ${listHppObats.length}');
      });
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListNotaTindakan() {
    if (listNotaTindakan.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listNotaTindakan.length,
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
                          builder: (context) => WidgetDetailNotaTindakan(
                              nota_id: listNotaTindakan[index].no_nota)));
                    },
                    title: Center(
                      child: Text('Nota ${listNotaTindakan[index].no_nota}' +
                          ' | Rp ${numberFormatRp.format(int.parse(listNotaTindakan[index].total_harga))}'),
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
    AkunanBacaDataDaftarNotaTindakan(widget.tgl_transaksi);
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
                "Daftar Nota Tindakan\n${widget.tgl_transaksi}",
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
            children: [widgetListNotaTindakan()],
          )),
    );
  }
}
