import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/controllers/controller_CoA.dart';

Future<void> ModalBottomAddCoA(BuildContext context) {
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
                        for (var item in listCoAController().listNamaAkun) {
                          print(item.nama);
                        }
                        Navigator.pop(ctx);
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