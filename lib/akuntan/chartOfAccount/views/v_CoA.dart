import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/services/fetchListCoA.dart';
import '../controllers/controller_CoA.dart';
import 'package:get/get.dart';

class ChartOfAccount extends StatefulWidget {
  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  final CoAController = Get.put(listCoAController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Chart Of Account')),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Obx(
            () => FutureBuilder(
                future: fetchAkuntanCoA(),
                builder: (context, snapshot) {
                  print('cek obx');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    var hasilGet = snapshot.data['data'];
                    print('cek snapshot.hasData ${hasilGet.length}');
                    return SingleChildScrollView(
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue[100]),
                          columns: [
                            DataColumn(label: Text('Nomor')),
                            DataColumn(label: Text('Nama')),
                          ],
                          rows: [
                            for (var i = 0; i < hasilGet.length; i++)
                              DataRow(cells: [
                                DataCell(Text('${hasilGet}')
                                    // TextFormField(
                                    //   // initialValue: '${hasilGet['no']}',
                                    //   enabled: false,
                                    // ),
                                    ),
                                DataCell(
                                  TextFormField(
                                    // initialValue: '${hasilGet['nama']}',
                                    enabled: false,
                                    // onChanged: (value) {
                                    //   CoAController.listNamaAkun[i].nama =
                                    //       value;
                                    //   print(
                                    //       "${CoAController.listNamaAkun[i].nama}");
                                    // },
                                  ),
                                ),
                              ]),
                          ]),
                    );
                  } else {
                    print('cek else');
                    return Text('data waiting');
                  }
                }),
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await ModalBottomAddCoA(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> ModalBottomAddCoA(BuildContext context) {
    TextEditingController _noAkun = TextEditingController();
    TextEditingController _namaAkun = TextEditingController();
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          // color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _noAkun,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'No Akun',
                  ),
                ),
                TextFormField(
                  controller: _namaAkun,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Nama Akun',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text('Tambah'),
                      onPressed: () {
                        CoAController.addAkunCoa(
                            _namaAkun.text, int.parse(_noAkun.text));
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
}
