import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/controllers/controller_CoA.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/services/fetchListCoA.dart';
import 'package:get/get.dart';
import 'add_CoA.dart';

class ChartOfAccount extends StatefulWidget {
  @override
  State<ChartOfAccount> createState() => _ChartOfAccountState();
}

class _ChartOfAccountState extends State<ChartOfAccount> {
  listCoAController CoaController = Get.put(listCoAController());
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
            child: FutureBuilder(
                future: fetchAkuntanCoA(),
                builder: (context, snapshot) {
                  print('cek obx');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    // List<DataCoA> _listCoA = [];
                    CoaController.listNamaAkun.clear();
                    var hasilGet = snapshot.data['data'];
                    for (var i in hasilGet) {
                      var jsnRslt = DataCoA.fromJson(i);
                      CoaController.listNamaAkun.add(jsnRslt);
                    }
                    return SingleChildScrollView(
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue[100]),
                          columns: [
                            DataColumn(label: Text('Nomor')),
                            DataColumn(label: Text('Nama')),
                          ],
                          rows: [
                            for (var i = 0;
                                i < CoaController.listNamaAkun.length;
                                i++)
                              DataRow(cells: [
                                DataCell(Text(
                                    '${CoaController.listNamaAkun[i].no}')),
                                DataCell(Text(
                                    '${CoaController.listNamaAkun[i].nama}')),
                              ]),
                          ]),
                    );
                  } else {
                    print('cek else');
                    return Text('data waiting');
                  }
                }),
          ),
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
}
