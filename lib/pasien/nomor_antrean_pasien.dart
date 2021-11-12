import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class PsienVNoAntr {
  var idUser, noAntre, tglVisit;
  PsienVNoAntr({this.idUser, this.noAntre, this.tglVisit});

  // untuk convert dari jSon
  factory PsienVNoAntr.fromJson(Map<String, dynamic> json) {
    return new PsienVNoAntr(
      idUser: json['id_user'],
      noAntre: json['no_antre'],
      tglVisit: json['tgl_visit'],
    );
  }
}

List<PsienVNoAntr> pVAs = [];

// ignore: must_be_immutable
class AntreanPasien extends StatefulWidget {
  var userKlinikId, tglVisit, antreanSekarang;
  AntreanPasien(
      {Key key, this.userKlinikId, this.tglVisit, this.antreanSekarang})
      : super(key: key);

  @override
  _AntreanPasienState createState() => _AntreanPasienState();
}

class _AntreanPasienState extends State<AntreanPasien> {
  Future<String> fetchDataTglVstPsien() async {
    var response = await http
        .post(Uri.parse(apiUrl + "pasien_view_antrean_user_tgl.php"), body: {
      'user_klinik_id': widget.userKlinikId.toString(),
      'tgl_visit': widget.tglVisit.toString()
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataTglVstPsien() {
    Future<String> data = fetchDataTglVstPsien();
    data.then((value) {
      // ignore: unused_local_variable
      setState(() {
        Map json = jsonDecode(value);
        if (json['result'].toString() == 'success') {
          for (var i in json['data']) {
            PsienVNoAntr pva = PsienVNoAntr.fromJson(i);
            pVAs.add(pva);
          }
        } else {}
        setState(() {
          // print('jumhlas data antre: ');
          // print('jumhlas data antre: ' + PVAs.length.toString());
        });
      });
    });
  }

  @override
  void initState() {
    pVAs.clear();
    bacaDataTglVstPsien();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Antrean'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: fetchDataTglVstPsien(),
            builder: (context, snapshot) {
              print(pVAs.length);
              if (snapshot.hasData) {
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pVAs.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          children: [
                            Text(
                              "nomor antrean anda:",
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              pVAs[index].noAntre.toString(),
                              style: TextStyle(
                                  fontSize: 88, color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Tanggal Visit:',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              pVAs[index].tglVisit.toString(),
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'antrean saat ini:',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.antreanSekarang.toString(),
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 50),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              thickness: 8,
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
