import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_get_list_obat.dart';
import 'apt_get_resep_pasien_detail.dart';
import 'apt_input_obat.dart';

class AptInputNamaPembeli extends StatefulWidget {
  final aptkrId, namaPasien, tgl_resep;

  const AptInputNamaPembeli(
      {Key key, this.aptkrId, this.namaPasien, this.tgl_resep})
      : super(key: key);

  @override
  _AptInputNamaPembeliState createState() => _AptInputNamaPembeliState();
}

class _AptInputNamaPembeliState extends State<AptInputNamaPembeli> {
  TextEditingController controllerNamaPembeli = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile
  // ignore: missing_return

  @override
  void initState() {
    aVKODrs.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var aptkrRspId;
  var btnSimpanEnable = true;
  // ignore: missing_return
  Widget widgetButtonSimpan() {
    if (btnSimpanEnable == true) {
      return TextButton(
        onPressed: () {
          fetchDataApotekerInputRsp(
                  widget.aptkrId, widget.tgl_resep, controllerNamaPembeli.text)
              .then((value) {
            Map json = jsonDecode(value);
            aptkrRspId = json['id_resep_apoteker'].toString();
            btnSimpanEnable = false;
            setState(() {
              widgetButtonSimpan();
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AptInputObat(
                          aptkrId: widget.aptkrId,
                          namaPembeli: controllerNamaPembeli.text,
                          rspId: aptkrRspId,
                        )));
          });
        },
        child: Text('SIMPAN'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(MediaQuery.of(context).size.width, 10)),
      );
    } else {
      return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('BACK'),
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: Size(MediaQuery.of(context).size.width, 10)),
      );
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [Text('Input Resep'), Text('${widget.tgl_resep}')],
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  color: Colors.green[50],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: controllerNamaPembeli,
                            decoration: InputDecoration(
                              labelText: "Nama Pembeli",
                              fillColor: Colors.white,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(Icons.person),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            )),
                      ),
                      widgetButtonSimpan()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
