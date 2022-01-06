import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pasien/pendaftaran_pasien_baru/pasien_get_post_data.dart';

final _controllerUsername = TextEditingController();
final _controllerSandi = TextEditingController();
final _controllerSandi2 = TextEditingController();
final _controllerNik = TextEditingController();
final _controllerNamaLengkap = TextEditingController();
final _controllerTglLahir = TextEditingController();
final _controllerTempatLahir = TextEditingController();
final _controllerKelamin = TextEditingController();
final _controllerAgama = TextEditingController();
final _controllerPekerjaan = TextEditingController();
final _controllerKewarganegaraan = TextEditingController();
final _controllerAlamat = TextEditingController();
final _controllerGolonganDarah = TextEditingController();
final _controllerPernikahan = TextEditingController();
final _controllerTelepon = TextEditingController();
String availableUsername,
    valueStatusPernikahan,
    valueKelamin,
    valueGolonganDarah,
    valueAgama,
    valuePekerjaan = '';
List<String> listStatusPernikahans = [
  'belum kawin',
  'kawin',
  'cerai hidup',
  'cerai mati'
];
List<String> listStatusKelamin = ['Laki-laki', 'Perempuan'];
List<String> listStatusGolonganDarah = [
  'A',
  'B',
  'AB',
  'O',
  'A+',
  'A‑',
  'B+',
  'B‑',
  'AB+',
  'AB‑',
  'O+',
  'O‑'
];
List<String> listStatusAgama = [
  'Islam',
  'Kristen',
  'Katolik',
  'Budha',
  'Hindu',
  'Konghuchu'
];
List<String> listStatusPekerjaan = [
  '-',
  'Belum/ Tidak Bekerja',
  'Mengurus Rumah Tangga',
  'Pelajar/ Mahasiswa',
  'Pensiunan',
  'Pewagai Negeri Sipil',
  'Tentara Nasional Indonesia',
  'Kepolisisan RI',
  'Wiraswasta',
  'Karyawan Swasta',
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
    _controllerUsername.text = '';
    _controllerSandi.text = '';
    _controllerSandi2.text = '';
    _controllerNik.text = '';
    _controllerNamaLengkap.text = '';
    _controllerTglLahir.text = '';
    _controllerTempatLahir.text = '';
    _controllerKelamin.text = 'Laki-Laki';
    _controllerGolonganDarah.text = '';
    _controllerAgama.text = '';
    _controllerPekerjaan.text = 'Belum/ Tidak Bekerja';
    _controllerKewarganegaraan.text = '';
    _controllerAlamat.text = '';
    _controllerTelepon.text = '';
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
                _controllerNik.clear();
                _controllerNamaLengkap.clear();
                _controllerTglLahir.clear();
                _controllerTempatLahir.clear();
                _controllerKelamin.clear();
                _controllerGolonganDarah.clear();
                _controllerAgama.clear();
                _controllerPekerjaan.clear();
                _controllerKewarganegaraan.clear();
                _controllerAlamat.clear();
                _controllerTelepon.clear();
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
                        labelText: "Jenis Kelamin: ",
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
                    hint: Text("Jenis Kelamin"),
                    value: valueKelamin,
                    items: listStatusKelamin.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valueKelamin = value;
                        _controllerKelamin.text = value;
                        print('$valueKelamin');
                      });
                    },
                  ),
                ),
              ],
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
                        labelText: "Golongan Darah: ",
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
                    hint: Text("Golongan Darah"),
                    value: valueGolonganDarah,
                    items: listStatusGolonganDarah.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valueGolonganDarah = value;
                        _controllerGolonganDarah.text = value;
                        print('${_controllerGolonganDarah.text}');
                      });
                    },
                  ),
                ),
              ],
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
                        labelText: "Status Pernikahan: ",
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
                        _controllerPernikahan.text = value;
                        print('${_controllerPernikahan.text}');
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Pekerjaan : ",
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
                    hint: Text("Pekerjaan"),
                    value: _controllerPekerjaan.text,
                    items: listStatusPekerjaan.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valuePekerjaan = value;
                        _controllerPekerjaan.text = value;
                        print('${_controllerPekerjaan.text}');
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
                controller: _controllerKewarganegaraan,
                decoration: InputDecoration(
                  labelText: "Kewarganegaraan",
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
                        enabled: false,
                        maxLines: 15,
                        initialValue: 'Username: ${_controllerUsername.text}\n' +
                            'NIK: ${_controllerNik.text}\n' +
                            'Nama: ${_controllerNamaLengkap.text}\n' +
                            'Kelamin: ${_controllerKelamin.text}\n' +
                            'Alamat: ${_controllerAlamat.text}\n' +
                            'Tempat Lahir: ${_controllerTempatLahir.text}\n' +
                            'Tanggal Lahir: ${_controllerTglLahir.text}\n' +
                            'Jenis Kelamin: ${_controllerKelamin.text}\n' +
                            'Golongan Darah: ${_controllerGolonganDarah.text}\n' +
                            'Status Pernikahan: ${_controllerPernikahan.text}\n' +
                            'Pekerjaan: ${_controllerPekerjaan.text}\n' +
                            'Kewarganegaraan: ${_controllerKewarganegaraan.text}\n' +
                            'Tlp: ${_controllerTelepon.text}',
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal')),
                        TextButton(
                            onPressed: () {
                              fetchDataPostDaftarBaru(
                                      _controllerUsername.text,
                                      _controllerSandi.text,
                                      _controllerNik.text,
                                      _controllerNamaLengkap.text,
                                      _controllerAlamat.text,
                                      _controllerAgama.text,
                                      _controllerTempatLahir.text,
                                      _controllerTglLahir.text,
                                      _controllerKelamin.text,
                                      _controllerGolonganDarah.text,
                                      _controllerPernikahan.text,
                                      _controllerPekerjaan.text,
                                      _controllerKewarganegaraan.text,
                                      _controllerTelepon.text)
                                  .then((value) {
                                _controllerUsername.text = '';
                                _controllerSandi.text = '';
                                _controllerNik.text = '';
                                _controllerNamaLengkap.text = '';
                                _controllerAlamat.text = '';
                                _controllerAgama.text = '';
                                _controllerTempatLahir.text = '';
                                _controllerTglLahir.text = '';
                                _controllerKelamin.text = '';
                                _controllerGolonganDarah.text = '';
                                _controllerPernikahan.text = '';
                                _controllerPekerjaan.text = '';
                                _controllerKewarganegaraan.text = '';
                                _controllerTelepon.text = '';
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Pendaftaran Berhasil!',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    // content: TextFormField(
                                    //     enabled: false,
                                    //     maxLines: 8,
                                    //     initialValue: '$value'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ok')),
                                    ],
                                  ),
                                );
                              });
                              Navigator.pop(context);
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
