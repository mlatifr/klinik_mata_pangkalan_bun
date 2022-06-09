import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/controller/daftar_pegawai_controller.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/service/post_add_pegawai.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/view/daftar_pegawai_view.dart';
import 'package:get/get.dart';

Future<void> AddPegawaiModalBottom(context, _pegawaiController) {
  DaftarPegawaiController _daftarPegawai = DaftarPegawaiController();
  TextEditingController _username = TextEditingController();
  TextEditingController _sandi = TextEditingController();
  TextEditingController _sandi2 = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _tlp = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  Icon ikonKonfirmasiPassword = Icon(
    Icons.remove_circle,
    color: Colors.red,
  );
  Icon ikonViciblityPassword = Icon(
    Icons.visibility_off,
    // color: Colors.red,
  );
  bool boolVisibility = true;
  return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height +
                  (MediaQuery.of(context).size.height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                    onChanged: (value) {
                      for (var i in _daftarPegawai.listPegawai) {}
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            obscureText: boolVisibility,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _sandi,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            )),
                      ),
                      IconButton(
                        icon: ikonViciblityPassword,
                        onPressed: () {
                          setState(() {
                            boolVisibility = !boolVisibility;
                            if (boolVisibility) {
                              ikonViciblityPassword = Icon(Icons.visibility);
                            }
                            if (!boolVisibility) {
                              ikonViciblityPassword =
                                  Icon(Icons.visibility_off);
                            }
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: boolVisibility,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _sandi2,
                          decoration: InputDecoration(
                            hintText: 'Konfirmasi password',
                          ),
                          onChanged: (value) {
                            print('value: $value');
                            if (_sandi.text == value.toString() &&
                                value != '') {
                              setState(() {
                                ikonKonfirmasiPassword = Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                );
                              });
                            } else {
                              setState(() {
                                ikonKonfirmasiPassword = Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                );
                              });
                            }
                          },
                        ),
                      ),
                      ikonKonfirmasiPassword
                    ],
                  ),
                  TextFormField(
                    controller: _nama,
                    decoration: InputDecoration(
                      hintText: 'Nama Akun',
                    ),
                  ),
                  TextFormField(
                    controller: _tlp,
                    decoration: InputDecoration(
                      hintText: 'Telepon',
                    ),
                  ),
                  TextFormField(
                    controller: _alamat,
                    maxLines: 5,
                    minLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Alamat',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: (Colors.red[400])),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 22),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: (Colors.blue[400])),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          modalBottomKonfirmasi(context, _pegawaiController,
                              _username, _sandi, _nama, _tlp, _alamat);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}

Future modalBottomKonfirmasi(BuildContext context, _pegawaiController,
    _username, _sandi, _namaAkun, _tlp, _alamat) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Simpan:'
                '\nUsername: \n${_username.text}'
                '\nNama Akun:\n${_namaAkun.text}'
                '\nTelepon: \n${_tlp.text}'
                '\nAlamat:\n${_alamat.text}'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: (Colors.red[400])),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Get.back();
                  },
                ),
                SizedBox(width: 22),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: (Colors.blue[400])),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    PostAddPegawai(_username.text, _sandi.text, _namaAkun.text,
                            _tlp.text, _alamat.text)
                        .then((value) {
                      print(value);
                      if (value.toString().contains('success')) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
