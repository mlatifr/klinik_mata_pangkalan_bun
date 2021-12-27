import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'akuntan_fetch_penjualan_nota.dart';

int totalPenjualan = 0;

// ignore: must_be_immutable
class WidgetAkunObatNotaDetail extends StatefulWidget {
  var nota_id;
  WidgetAkunObatNotaDetail({Key key, this.nota_id}) : super(key: key);

  @override
  _WidgetAkunObatNotaDetailState createState() =>
      _WidgetAkunObatNotaDetailState();
}

class _WidgetAkunObatNotaDetailState extends State<WidgetAkunObatNotaDetail> {
  //baca data nota akun obat
// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObatDetail(tgl) {
    listPenjualanObatNotas.clear();
    // print('listPenjualanObatNotas: ${listPenjualanObatNotas.length}');
    Future<String> data = fetchDataVPenjualanObatNota(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        //print(i);
        AkuntanVPenjualanNotaObat pjlnObtNota =
            AkuntanVPenjualanNotaObat.fromJson(i);
        listPenjualanObatNotas.add(pjlnObtNota);
      }
      setState(() {
        widgetListObatNota(listPenjualanObatNotas);
      });
    });
  }

  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListObatNota(plistPenjualanObatNotas) {
    totalPenjualan = 0;
    if (plistPenjualanObatNotas.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: plistPenjualanObatNotas.length,
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
                    onTap: () {},
                    title: Center(
                      child: Text(
                          'Nota ${plistPenjualanObatNotas[index].nota_id}'),
                    ),
                  ),
                ));
          });
    } else {
      return Column(
        children: [
          ListTile(title: Center(child: Text('${widget.nota_id}'))),
        ],
      );
    }
  }

  Widget widgetTextTotalPenjualanObat(
    plistPenjualanObatNotas,
  ) {
    if (plistPenjualanObatNotas.length > 0) {
      //print('ListPenjualanObat.length: ${plistPenjualanObatNotas.length}');
      for (var i = 0; i < plistPenjualanObatNotas.length; i++) {
        totalPenjualan += plistPenjualanObatNotas[i].totalHarga;
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Obat Rp ${numberFormatRp.format(totalPenjualan)}')),
      );
    } else {
      return Column(
        children: [
          // CircularProgressIndicator(),
          // Text('data tidak ditemukan'),
        ],
      );
    }
  }

  @override
  void initState() {
    AkunanBacaDataPenjualanObatDetail(widget.nota_id);
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
                "Detail Nota Obat :${widget.nota_id}",
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
            children: [widgetListObatNota(listPenjualanObatNotas)],
          )),
    );
  }
}
