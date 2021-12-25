import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/kasir/fetch_data/kasir_get_resep.dart';
import '../../main.dart';

Timer _timerForInter; // <- Put this line on top of _MyAppState class

// ignore: must_be_immutable
class KsrPmbliNonVst extends StatefulWidget {
  var kasirId;
  KsrPmbliNonVst({Key key, this.kasirId}) : super(key: key);

  @override
  _KsrPmbliNonVstState createState() => _KsrPmbliNonVstState();
}

var controllerdate = TextEditingController();

class _KsrPmbliNonVstState extends State<KsrPmbliNonVst> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n' + username,
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.85),
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('./asset/image/clinic_text.jpg'),
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              _timerForInter.cancel();
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  // // ignore: non_constant_identifier_names
  // KasirBacaDataVAntrean(pDate) {
  //   kVAs.clear();
  //   Future<String> data = fetchDataKasirVAntreanPasien(pDate);
  //   data.then((value) {
  //     //Mengubah json menjadi Array
  //     // ignore: unused_local_variable
  //     Map json = jsonDecode(value);
  //     for (var i in json['data']) {
  //       //print(i);
  //       KasirVAntrean kva = KasirVAntrean.fromJson(i);
  //       kVAs.add(kva);
  //     }
  //     setState(() {});
  //   });
  // }

  Widget widgetSelectTgl() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: controllerdate,
              onChanged: (value) {
                setState(() {
                  controllerdate.text = value.toString();
                  controllerdate.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerdate.text.length));
                  //print(value.toString());
                  // AdminBacaDataAntrean();
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Tanggal Visit',
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 10);
                      //print(value.toString());
                      KasirBacaDataVAntreanNonVisit(controllerdate.text);
                    });
                  });
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.white,
                  size: 24.0,
                ))
          ],
        ));
  }

// ignore: unused_field
  void functionTimerRefresh() {
    _timerForInter = Timer.periodic(Duration(seconds: 15), (result) {
      setState(() {
        // KasirBacaDataVAntrean(controllerdate.text);
      });
    });
  }

  // ignore: non_constant_identifier_names
  KasirBacaDataVAntreanNonVisit(pDate) {
    kasir_list_tgl_rsp_non_visit.clear();
    Future<String> data = fetchDataKasirVKrjgTglNonVisit(pDate);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('KasirBacaDataVAntreanNonVisit $i');
        KasirVKrjgTglNonVisit kva = KasirVKrjgTglNonVisit.fromJson(i);
        kasir_list_tgl_rsp_non_visit.add(kva);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    //print(date);
    controllerdate.text = date.toString().substring(0, 10);

    KasirBacaDataVAntreanNonVisit(controllerdate.text);
    // KasirBacaDataVAntrean(controllerdate.text);
    // kVAs = [];
    functionTimerRefresh();
    super.initState();
  }

  onGoBack(dynamic value) {
    //print('timer start');
    setState(() {
      // KasirBacaDataVAntrean(controllerdate.text);
      // widgetLsTile();
    });
  }

  Widget widgetLsTile() {
    if (kasir_list_tgl_rsp_non_visit.length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: kasir_list_tgl_rsp_non_visit.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                    child: ListTile(
                      onTap: () {
                        _timerForInter.cancel();
                        // //print('timer stop');
                        // Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => KasirDetailPasien(
                        //                 namaPasien: kVAs[index].userName,
                        //                 visitId: kVAs[index].visitId,
                        //                 visitDate: controllerdate.text
                        //                     .toString()
                        //                     .substring(0, 10))))
                        //     .then((onGoBack))
                        //     .then((value) => functionTimerRefresh());
                      },
                      leading: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: CircleAvatar(
                              child: Text(
                                  '${kasir_list_tgl_rsp_non_visit[index].resep_apoteker_id}'),
                            ),
                          ),
                          Expanded(flex: 2, child: Text('id resep'))
                        ],
                      ),
                      title: Center(
                        child: Text(
                            '${kasir_list_tgl_rsp_non_visit[index].nama_pembeli}'),
                      ),
                      // subtitle: Center(
                      //   child: Text(
                      //       'id resep ${kasir_krjg_rsp_apt_non_vst[index].resep_apoteker_id}'),
                      // ),
                      // trailing: widgetStatusAntrean(index)
                    ),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide()))),
              );
            }),
      );
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Daftar Pembelian"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              widgetSelectTgl(),
              widgetLsTile(),
            ],
          )),
    );
  }
}
