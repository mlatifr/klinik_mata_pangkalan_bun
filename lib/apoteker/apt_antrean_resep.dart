import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/apoteker/apt_input_nama_pembeli.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'apt_input_obat.dart';

class AptAntreanPasien extends StatefulWidget {
  const AptAntreanPasien({Key key}) : super(key: key);

  @override
  _AptAntreanPasienState createState() => _AptAntreanPasienState();
}

class ApotekerVAntrean {
  var visitId, vhuId, pasienId, tglVisit, namaPasien, nomorAntrean, statusAntrean;
  ApotekerVAntrean({
    this.visitId,
    this.namaPasien,
    this.vhuId,
    this.pasienId,
    this.tglVisit,
    this.nomorAntrean,
    this.statusAntrean,
  });

  // untuk convert dari jSon
  factory ApotekerVAntrean.fromJson(Map<String, dynamic> json) {
    return new ApotekerVAntrean(
      visitId: json['visit_id'],
      namaPasien: json['nama_pasien'],
      vhuId: json['vhu_id'],
      pasienId: json['pasien_id'],
      tglVisit: json['tgl_visit'],
      nomorAntrean: json['nomor_antrean'],
      statusAntrean: json['status_antrean'],
    );
  }
}

var controllerdate = TextEditingController();
// ignore: non_constant_identifier_names
List<ApotekerVAntrean> AptkrVAs = [];

class _AptAntreanPasienState extends State<AptAntreanPasien> {
  // ignore: unused_field
  Timer _timerForInter; // <- Put this line on top of _MyAppState class
  void functionTimerRefresh() {
    _timerForInter = Timer.periodic(Duration(seconds: 15), (result) {
      setState(() {
        ApotekerBacaDataAntrean();
      });
    });
  }

  void getUserIdApoteker() async {
    final prefs = await SharedPreferences.getInstance();
    userIdMainDart = prefs.getString("userid");
    setState(() {});
  }

  @override
  void initState() {
    getUserIdApoteker();
    print('user id apoteker $userIdMainDart');
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    // print(date);
    controllerdate.text = date.toString().substring(0, 10);
    ApotekerBacaDataAntrean();
    AptkrVAs = [];
    functionTimerRefresh();
    super.initState();
  }

  Future<String> fetchDataApotekerAntreanPasien() async {
    final response = await http.post(Uri.parse(apiUrl + "apoteker_v_antrean.php"), body: {
      'tgl_visit': controllerdate.text.toString().substring(0, 10),
      // 'tgl_visit': '2021-10-21',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  // ignore: non_constant_identifier_names
  ApotekerBacaDataAntrean() {
    AptkrVAs.clear();
    Future<String> data = fetchDataApotekerAntreanPasien();
    data.then((value) {
      print('fetchDataApotekerAntreanPasien: $value');
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        ApotekerVAntrean dva = ApotekerVAntrean.fromJson(i);
        AptkrVAs.add(dva);
      }
      setState(() {});
    });
  }

  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n ' + username,
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
            title: Text('Input Resep'),
            onTap: () {
              _timerForInter.cancel();
              print('timer stop');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AptInputNamaPembeli(
                            aptkrId: userIdMainDart,
                            tgl_resep: controllerdate.text,
                          ))).then((onGoBack));
            },
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

  onGoBack(dynamic value) {
    functionTimerRefresh();
    print('timer start');
    setState(() {
      ApotekerBacaDataAntrean();
      widgetLsTile();
    });
  }

  // ignore: missing_return
  Widget widgetStatusAntrean(int index) {
    if (AptkrVAs[index].statusAntrean.toString() == 'belum') {
      return CircleAvatar(radius: 15, child: Icon(Icons.watch_later_outlined));
    } else if (AptkrVAs[index].statusAntrean.toString() == 'sudah') {
      return CircleAvatar(radius: 15, child: Icon(Icons.check));
    } else if (AptkrVAs[index].statusAntrean.toString() == 'batal') {
      return CircleAvatar(
          radius: 15,
          backgroundColor: Colors.red[400],
          child: Icon(
            Icons.cancel,
            color: Colors.white,
          ));
    }
  }

  Widget widgetLsTile() {
    if (AptkrVAs.length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: AptkrVAs.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    onTap: () {
                      _timerForInter.cancel();
                      print('timer stop');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AptInputObat(
                                    aptkrId: userIdMainDart,
                                    namaPasien: AptkrVAs[index].namaPasien,
                                    visitId: AptkrVAs[index].visitId,
                                  ))).then((onGoBack));
                    },
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('${AptkrVAs[index].namaPasien}'),
                    subtitle: Text('No Visit: ${AptkrVAs[index].visitId}'),
                    // trailing: widgetStatusAntrean(index)
                  ));
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

  // (beli x jumlah + biaya )\jumlah
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
                  controllerdate.selection = TextSelection.fromPosition(TextPosition(offset: controllerdate.text.length));
                  print(value.toString());
                  // AdminBacaDataAntrean();
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2200)).then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 10);
                      print(value.toString());
                      ApotekerBacaDataAntrean();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Antrean Pasien"),
          ),
          drawer: widgetDrawer(),
          body: Column(
            children: [
              widgetSelectTgl(),
              widgetLsTile(),
            ],
          )),
    );
  }
}
