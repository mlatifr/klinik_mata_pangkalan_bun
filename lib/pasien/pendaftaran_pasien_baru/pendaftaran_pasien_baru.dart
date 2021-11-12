import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/pasien/pendaftaran_pasien_baru/pasien_cek_available.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

final _controllerTglLahir = TextEditingController();
final _controllerUsername = TextEditingController();
final _controllerSandi = TextEditingController();
final _controllerSandi2 = TextEditingController();
final _controllersNik = TextEditingController();
final _controllersNamaLengkap = TextEditingController();
String AvailableUsername = '';

class PagePasienDaftarBaru extends StatefulWidget {
  const PagePasienDaftarBaru({Key key}) : super(key: key);

  @override
  _PagePasienDaftarBaruState createState() => _PagePasienDaftarBaruState();
}

class _PagePasienDaftarBaruState extends State<PagePasienDaftarBaru> {
  PasienBacaDataAvailableUsername(username) {
    AvailableUsername = '';
    Future<String> data = fetchDataAvailableUsername(username);
    data.then((value) {
      //Mengubah json menjadi string
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['data'] == 'username available') {
        AvailableUsername = json['data'].toString();
      }
      setState(() {
        widgetUsernameCheck();
      });
    });
  }

  Widget widgetUsernameCheck() {
    if (AvailableUsername == 'username available') {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else
      return Icon(
        Icons.cancel_sharp,
        color: Colors.red,
      );
  }

  Widget widgetSandiCheck() {
    if (_controllerSandi.text == _controllerSandi2.text &&
        _controllerSandi.text != '' &&
        _controllerSandi2.text != '') {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else if (_controllerSandi.text == '' && _controllerSandi2.text == '') {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          'sandi tidak boleh kosong!',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else
      return Icon(
        Icons.cancel_sharp,
        color: Colors.red,
      );
  }

  Widget widgetSandiText() {
    if (_controllerSandi.text != _controllerSandi2.text) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          'sandi tidak sama!',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (_controllerSandi.text == '' && _controllerSandi2.text == '') {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          'sandi tidak boleh kosong!',
          style: TextStyle(color: Colors.red),
        ),
      );
    } else
      return Icon(
        Icons.check,
        color: Colors.green,
      );
  }

  @override
  void initState() {
    _controllerUsername.clear();
    _controllerSandi.text = '';
    _controllerSandi2.clear();
    _controllerTglLahir.clear();
    _controllersNik.clear();
    _controllersNamaLengkap.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pendaftaran Pasien Baru'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              // onPressed: () => Navigator.of(context).pop(),
              onPressed: () {
                _controllerUsername.clear();
                _controllerSandi.clear();
                _controllerSandi2.clear();
                _controllerTglLahir.clear();
                _controllersNik.clear();
                _controllersNamaLengkap.clear();
                Navigator.pop(context);
              }),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 8,
                  child: TextFormField(
                      controller: _controllerUsername,
                      onChanged: (value) {
                        PasienBacaDataAvailableUsername(
                            _controllerUsername.text);
                      },
                      decoration: InputDecoration(
                        labelText: "Username",
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
                ),
                Expanded(flex: 2, child: widgetUsernameCheck())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          widgetSandiCheck();
                          widgetSandiText();
                        });
                      },
                      controller: _controllerSandi,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Sandi",
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
                ),
                Expanded(flex: 2, child: widgetSandiText())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: TextFormField(
                      controller: _controllerSandi2,
                      onChanged: (value) {
                        setState(() {
                          widgetSandiCheck();
                          widgetSandiText();
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Ulangi Sandi",
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
                ),
                Expanded(flex: 2, child: widgetSandiCheck())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: "NIK: Nomor Induk Kependudukan",
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Nama Lengkap",
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Alamat",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Tempat Lahir",
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
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        controller: _controllerTglLahir,
                      )),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              setState(() {
                                _controllerTglLahir.text =
                                    value.toString().substring(0, 10);
                              });
                            });
                          },
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 32.0,
                          )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Tanggal Lahir",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Status Perkawinan",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                maxLength: 5,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                decoration: InputDecoration(
                  labelText: "Telepon",
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
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap Isian diperbaiki')));
                },
                child: Text("SIMPAN"))
          ],
        ),
      ),
    );
  }
}
