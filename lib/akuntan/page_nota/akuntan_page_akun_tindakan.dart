import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

int totalTindakanOperasi = 0;

class WidgetAkunTindakan extends StatefulWidget {
  var pTextDaftarPenjualanTindakna;
  WidgetAkunTindakan({Key key, this.pTextDaftarPenjualanTindakna})
      : super(key: key);

  @override
  _WidgetAkunTindakanState createState() => _WidgetAkunTindakanState();
}

class _WidgetAkunTindakanState extends State<WidgetAkunTindakan> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListTindakan(pTextDaftarPenjualanTindakna) {
    totalTindakanOperasi = 0;
    if (listPenjualanTindakans.length > 0) {
      return ExpansionTile(
          title: Text('$pTextDaftarPenjualanTindakna'),
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listPenjualanTindakans.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                              '${listPenjualanTindakans[index].tglTindakan}'),
                          subtitle: Text(
                              '${listPenjualanTindakans[index].namaPasien} \n${listPenjualanTindakans[index].namaTindakan} \nRp ${numberFormatRp.format(listPenjualanTindakans[index].harga)}'),
                        ),
                      ));
                }),
          ]);
    } else
      return Container();
  }

  Widget widgetTextTotalPenjualanJasmed() {
    if (listPenjualanTindakans.length > 0) {
      //print('ListPenjualanJasmed.length: ${listPenjualanTindakans.length}');
      for (var i = 0; i < listPenjualanTindakans.length; i++) {
        totalTindakanOperasi += listPenjualanTindakans[i].harga;
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Jasmed Rp ${numberFormatRp.format(totalTindakanOperasi)}')),
      );
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListTindakan(widget.pTextDaftarPenjualanTindakna),
        widgetTextTotalPenjualanJasmed(),
      ],
    );
  }
}
