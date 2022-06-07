import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/controllers/controller_CoA.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:get/get.dart';

Future<void> ModalBottomAddCoA(BuildContext context) {
  listCoAController coaC = Get.put(listCoAController());
  TextEditingController _noAkun = TextEditingController();
  TextEditingController _namaAkun = TextEditingController();
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext ctx) {
      return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _noAkun,
                decoration: InputDecoration(
                  hintText: 'No Akun',
                ),
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
                    child: const Text('Tambah'),
                    onPressed: () {
                      for (var i = 0; i < coaC.listNamaAkun.length; i++) {
                        print(coaC.listNamaAkun[i].nama);
                      }
                      coaC.listNamaAkun.add(DataCoA(
                          no: int.parse(_noAkun.text), nama: _namaAkun.text));
                      print(
                          '${coaC.listNamaAkun.last.no} | ${coaC.listNamaAkun.last.nama}');
                      Get.back();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Batal'),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
