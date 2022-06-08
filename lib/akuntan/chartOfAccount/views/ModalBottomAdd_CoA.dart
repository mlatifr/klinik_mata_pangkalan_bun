import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/controllers/controller_CoA.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<void> ModalBottomAddCoA(
    BuildContext context, CoaController, _modelScaffoldKey) {
  TextEditingController _noAkun = TextEditingController();
  TextEditingController _namaAkun = TextEditingController();
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext ctx) {
      return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _noAkun,
              decoration: InputDecoration(
                hintText: 'No Akun',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            TextFormField(
              controller: _namaAkun,
              decoration: InputDecoration(
                hintText: 'Nama Akun',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: (Colors.red[400])),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                ),
                ElevatedButton(
                  child: const Text('Tambah'),
                  onPressed: () {
                    // for (var i = 0; i < coaC.listNamaAkun.length; i++) {
                    //   print(coaC.listNamaAkun[i].nama);
                    // }
                    if (_noAkun.text != '' && _namaAkun.text != '') {
                      CoaController.listNamaAkun.add(DataCoA(
                          no: int.parse(_noAkun.text), nama: _namaAkun.text));
                      return ModalBottomKonfirmasi(
                          ctx, _noAkun.text, _namaAkun.text);
                    } else {
                      return modalBottomIfNull(ctx);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

Future modalBottomIfNull(BuildContext ctx) {
  return showModalBottomSheet(
    context: ctx,
    builder: (ctx) {
      return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(ctx).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Nomor & Nama tidak boleh kosong!'),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: (Colors.blue[400])),
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

Future ModalBottomKonfirmasi(BuildContext ctx, no, nama) {
  return showModalBottomSheet(
    context: ctx,
    builder: (ctx) {
      return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(ctx).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Simpan no akun: \n $no \nNama: \n $nama '),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: (Colors.red[400])),
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(width: 22),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: (Colors.blue[400])),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
