import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_antrean/admin_antrean_pasien.dart';
import 'package:flutter_application_1/admin_order_obat/admOrderObat_main_page.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/pasien/nomor_antrean_pasien.dart';
import 'package:flutter_application_1/pasien/nota_pembayaran.dart';
import 'package:flutter_application_1/pasien/pasien_fetch_visit_id.dart';
import 'package:flutter_application_1/pasien/riwayat_periksa.dart';
import 'package:flutter_application_1/pasien/pendaftaran_pasien_baru/pendaftaran_pasien_baru.dart';
import 'package:flutter_application_1/pemilik/pemilik_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'akuntan/akuntan_main_page.dart';
import 'apoteker/apt_antrean_resep.dart';
import 'dokter/dr_antrean_pasien.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'kasir/kasir_antrean_pasien.dart';

DateTime now = new DateTime.now();
DateTime date = new DateTime(now.year, now.month, now.day);
// ignore: non_constant_identifier_names
String username, userIdMainDart = ""; 
var keluhan = TextEditingController();
// ignore: non_constant_identifier_names
String statusAntrean, navigateToNomorAntrean;
int antreanSekarang, antreanTerakhir, batasAntrean;
String apiUrl = "https://localhost/tugas_akhir/";
// String apiUrl = "https://192.168.1.8/tugas_akhir/";
// String apiUrl = "https://192.168.43.5/tugas_akhir/";
// String apiUrl = "https://192.168.1.96//tugas_akhir/";
void getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  userIdMainDart = prefs.getString("userid");
  print('user id main: $userIdMainDart');
}

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("_username");
  prefs.remove("userid");
  print('user id doLogout(): $userIdMainDart');
  userIdMainDart = '';
  main();
}

// ignore: missing_return
Future<String> cekLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    String _username = prefs.getString("_username") ?? '';
    // print('cek _username = $_username');
    return _username;
  } catch (e) {
    print('error karena $e');
  }
}

// untuk allow certificates login
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // runApp(MyApp());
  HttpOverrides.global =
      new MyHttpOverrides(); // untuk allow certificates login
  WidgetsFlutterBinding.ensureInitialized();

  cekLogin().then((String result) {
    if (result == 'daftarBaru') {
      username = result;
      runApp(MaterialApp(
        home: PagePasienDaftarBaru(),
        debugShowCheckedModeBanner: false,
      ));
    } else if (result == '' && result != 'daftarBaru') {
      username = result;
      runApp(MaterialApp(home: LoginPage()));
    } else if (result.contains('pemilik')) {
      username = result;
      runApp(MaterialApp(home: PemilikMainPage()));
    } else if (result.contains('admin_antrean')) {
      username = result;
      runApp(MaterialApp(home: AdminAntreanPasien()));
    } else if (result.contains('admin_order')) {
      username = result;
      runApp(MaterialApp(home: AdmOrderObatMainPage()));
    } else if (result.contains('dokter')) {
      username = result;
      runApp(MaterialApp(home: DrAntreanPasien()));
    } else if (result.contains('apoteker')) {
      username = result;
      runApp(MaterialApp(home: AptAntreanPasien()));
    } else if (result.contains('kasir')) {
      username = result;
      runApp(MaterialApp(home: KsrAntreanPasien()));
    } else if (result.contains('akuntan')) {
      username = result;
      runApp(MaterialApp(home: AkuntanMainPage()));
    } else if (result != null || result != '') {
      username = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Pendaftaran Visit',
      ),
      // home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//untuk memasukan keluhan + nomor antrean: pasien_input_keluhan.php
  Future<String> fetchDataKeluhan() async {
    print("antrean_terakhir: $antreanTerakhir");
    final response =
        await http.post(Uri.parse(apiUrl + "pasien_input_keluhan.php"), body: {
      'keluhan': keluhan.text,
      'no_antrean': antreanTerakhir.toString(),
      'user_klinik_id': userIdMainDart.toString()
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataKeluhan(context) {
    navigateToNomorAntrean = null;
    antreanTerakhir = antreanTerakhir + 1;
    Future<String> data = fetchDataKeluhan();
    data.then((value) {
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'success') {
        Navigator.pop(context);
        keluhan.clear();
        print("navigateToNomorAntrean 2:$navigateToNomorAntrean");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AntreanPasien(
                    userKlinikId: userIdMainDart,
                    tglVisit: date.toString().substring(0, 10),
                    antreanSekarang: antreanSekarang.toString())));
        setState(() {
          navigateToNomorAntrean = 'success';
        });
      } else {
        print(json);
      }
      print(json);
    });
  }

// untuk mengecek antrean
  Future<String> fetchDataAntreanSekarang() async {
    final response =
        await http.post(Uri.parse(apiUrl + "pasien_view_antrean_sekarang.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataAntrean() {
    Future<String> data = fetchDataAntreanSekarang();
    data.then((value) {
      // ignore: unused_local_variable
      setState(() {
        Map json = jsonDecode(value);
        statusAntrean = json['status_antrean'];
        //antrean yg sedang di dalam ruang periksa
        antreanSekarang = json['antrean_sekarang'];
        //no pendaftar visit pasien terakhir
        antreanTerakhir = json['antrean_terakhir'];
        batasAntrean = json['batas_antrean'];
      });
    });
  }

  @override
  void initState() {
    getUserId();
    print('user id main init state $userIdMainDart');
    // DateTime nowVisitId = new DateTime.now();
    // DateTime dateVisitId = new DateTime(nowVisitId.year, nowVisitId.month, nowVisitId.day);
    bacaDataAntrean();
    super.initState();
  }

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
            title: Text('Nomor Antrean'),
            onTap: () {
              getUserId();
              print('onTap');
              print(
                  "userid: $userIdMainDart | tgl_visit: ${date.toString().substring(0, 10)} | antrean_sekarang: $antreanSekarang");
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AntreanPasien(
                          userKlinikId: userIdMainDart,
                          tglVisit: date.toString().substring(0, 10),
                          antreanSekarang: antreanSekarang.toString())));
            },
          ),
          ListTile(
            title: Text('Nota Pembayaran'),
            onTap: () {
              if (visitIdPasien == 0) {
                getUserId();
                //perbaiki disini error masihan kliru di userMain,Dart telat baca data
                print('useridMainDart: main page $userIdMainDart');
                fetchDataVisitId(
                        userIdMainDart, date.toString().substring(0, 10))
                    .then((value) {
                  Map json = jsonDecode(value);
                  visitIdPasien = json['visit_id'];
                  // print('visitIdPasien: $visitIdPasien | $date');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotaPembayaranPasien(
                                visitId: visitIdPasien,
                              )));

                  print('visitIdPasien: $visitIdPasien after nol');
                });
              } else {
                print(visitIdPasien);
              }
            },
          ),
          ListTile(
            title: Text('Riwayat Pemeriksaan'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RiwayatPeriksaPasien()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              print(
                  "antrean_sekarang= $antreanSekarang antrean_terakhir= $antreanTerakhir");
              if (antreanSekarang != null) {
                antreanSekarang = 0;
                antreanTerakhir = 0;
                print(
                    "antrean_sekarang= $antreanSekarang antrean_terakhir= $antreanTerakhir");
              }
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: widgetDrawer(),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  './asset/image/clinic_text.jpg',
                  width: 250,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text('Selamat Datang'),
              Text(username),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                  maxLines: 8,
                  controller: keluhan,
                  decoration: InputDecoration(
                    labelText: "ketik keluhan disini",
                    fillColor: Colors.white,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      print('userid: $userIdMainDart');
                      getUserId();
                      bacaDataAntrean();
                      print("antrean_terakhir tombol simpan: $antreanTerakhir");
                      if (antreanTerakhir != null) {
                        if (batasAntrean > antreanTerakhir) {
                          setState(() {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Anda akan mendaftar dengan keluhan:',
                                  style: TextStyle(fontSize: 14),
                                ),
                                content: TextFormField(
                                    enabled: false,
                                    maxLines: 5,
                                    controller: keluhan,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      bacaDataKeluhan(context);
                                      print(
                                          "navigateToNomorAntrean :$navigateToNomorAntrean");
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          });
                        } else {
                          setState(() {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'mohon maaf, antrean visit telah ditutup',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          });
                        }
                      } else {
                        setState(() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'antrean_terakhir $antreanTerakhir',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: Text(
                      'SIMPAN',
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
