import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_get_list_obat.dart';
import 'apt_get_resep_pasien_detail.dart';
import 'apt_input_obat.dart';

class AptInputNamaPembeli extends StatefulWidget {
  final aptkrId, namaPasien;

  const AptInputNamaPembeli({
    Key key,
    this.aptkrId,
    this.namaPasien,
  }) : super(key: key);

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

  // ignore: missing_return
  Widget widgetButtonSimpan() {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AptInputObat(
                      aptkrId: widget.aptkrId,
                      namaPembeli: controllerNamaPembeli.text,
                    )));
      },
      child: Text('SIMPAN'),
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
          minimumSize: Size(MediaQuery.of(context).size.width, 10)),
    );
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Input Resep'),
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
