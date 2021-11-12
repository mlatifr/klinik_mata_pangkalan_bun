import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pasien/pendaftaran_pasien_baru/pasien_cek_available.dart';

final _controllerTglLahir = TextEditingController();
final _controllerUsername = TextEditingController();
final _controllerSandi = TextEditingController();
final _controllerSandi2 = TextEditingController();
final _controllerNik = TextEditingController();
final _controllerNamaLengkap = TextEditingController();
final _controllerAlamat = TextEditingController();
final _controllerTempatLahir = TextEditingController();
final _controllerTelepon = TextEditingController();
String availableUsername, valueStatusPernikahan = '';
List<String> listStatusPernikahans = [
  'belum kawin',
  'kawin',
  'cerai hidup',
  'cerai mati'
];

class PagePasienDaftarBaru extends StatefulWidget {
  const PagePasienDaftarBaru({Key key}) : super(key: key);

  @override
  _PagePasienDaftarBaruState createState() => _PagePasienDaftarBaruState();
}

class _PagePasienDaftarBaruState extends State<PagePasienDaftarBaru> {
  pasienBacaDataAvailableUsername(username) {
    availableUsername = '';
    Future<String> data = fetchDataAvailableUsername(username);
    data.then((value) {
      //Mengubah json menjadi string
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['data'] == 'username available') {
        availableUsername = json['data'].toString();
      }
      setState(() {
        widgetUsernameCheck();
      });
    });
  }

  Widget widgetUsernameCheck() {
    if (availableUsername == 'username available' && availableUsername != '') {
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
    availableUsername = '';
    valueStatusPernikahan = 'belum kawin';
    _controllerUsername.clear();
    _controllerSandi.text = '';
    _controllerSandi2.clear();
    _controllerTglLahir.clear();
    _controllerNik.clear();
    _controllerNamaLengkap.clear();
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
                _controllerNik.clear();
                _controllerNamaLengkap.clear();
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
                        pasienBacaDataAvailableUsername(
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
              maxLength: 16,
              controller: _controllerNik,
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
                controller: _controllerNamaLengkap,
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
            TextFormField(
                controller: _controllerAlamat,
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
                controller: _controllerTempatLahir,
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
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2500))
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Status pernikahan: ",
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
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    itemHeight: 88.0,
                    hint: Text("Status Pernikahan"),
                    value: valueStatusPernikahan,
                    items: listStatusPernikahans.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valueStatusPernikahan = value;
                        print('$valueStatusPernikahan');
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _controllerTelepon,
                maxLength: 12,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
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
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Anda akan menyimpan data:',
                        style: TextStyle(fontSize: 14),
                      ),
                      content: TextFormField(
                        maxLines: 8,
                        initialValue:
                            'Username: ${_controllerUsername.text}\nNIK: ${_controllerNik.text}\nNama: ${_controllerNamaLengkap.text}\nAlamat: ${_controllerAlamat.text}\nTempat Lahir: ${_controllerTempatLahir.text}\nTanggal Lahir: ${_controllerTglLahir.text}\nTlp: ${_controllerTelepon.text}',
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('ok')),
                      ],
                    ),
                  );
                },
                child: Text("SIMPAN"))
          ],
        ),
      ),
    );
  }
}
