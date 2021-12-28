import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_obat_nota_detail.dart';
import 'package:intl/intl.dart';
import 'akuntan_fetch_penjualan_nota.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetAkunNotaPjnlObat extends StatefulWidget {
  var tgl_transaksi;
  WidgetAkunNotaPjnlObat({Key key, this.tgl_transaksi}) : super(key: key);

  @override
  _WidgetAkunNotaPjnlObatState createState() => _WidgetAkunNotaPjnlObatState();
}

class _WidgetAkunNotaPjnlObatState extends State<WidgetAkunNotaPjnlObat> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataDaftarNotaObat(tgl) {
    listNotaPjnlObat.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVPenjualanListNotaObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVPenjualanNotaObat pjlnObtNota =
            AkuntanVPenjualanNotaObat.fromJson(i);
        listNotaPjnlObat.add(pjlnObtNota);
      }
      setState(() {
        widgetListObatNota();
        print('listNotaPjnlObat.length ${listNotaPjnlObat.length}');
      });
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObatNota() {
    if (listNotaPjnlObat.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listNotaPjnlObat.length,
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
                          builder: (context) => WidgetDetailNotaObat(
                              nota_id: listNotaPjnlObat[index].nota_id)));
                    },
                    title: Center(
                      child: Text('Nota ${listNotaPjnlObat[index].nota_id}'),
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
    AkunanBacaDataDaftarNotaObat(widget.tgl_transaksi);
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
                "Daftar Nota Obat\n       ${widget.tgl_transaksi}",
                maxLines: 2,
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
