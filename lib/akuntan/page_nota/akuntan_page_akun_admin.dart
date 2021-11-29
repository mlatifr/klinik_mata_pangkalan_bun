import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

class WidgetAkunAdmin extends StatefulWidget {
  var pTextTittle, pTextTotal;
  WidgetAkunAdmin({Key key, this.pTextTittle, this.pTextTotal})
      : super(key: key);

  @override
  _WidgetAkunAdminState createState() => _WidgetAkunAdminState();
}

class _WidgetAkunAdminState extends State<WidgetAkunAdmin> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListAdmin() {
    if (listPenjualanAdmins.length > 0) {
      return ExpansionTile(title: Text('${widget.pTextTittle}'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listPenjualanJasmeds.length,
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
                      title: Text('${listPenjualanAdmins[index].namaPasien}'),
                      subtitle: Text(
                          '${listPenjualanAdmins[index].tglTransaksi} \nRp ${numberFormatRp.format(listPenjualanAdmins[index].harga)}'),
                    ),
                  ));
            }),
      ]);
    } else
      return Container();
  }

  Widget widgetTextTotalPenjualanAdmin() {
    int total = 0;
    if (listPenjualanAdmins.length > 0) {
      //print('ListPenjualanJasmed.length: ${listPenjualanAdmins.length}');
      for (var i = 0; i < listPenjualanAdmins.length; i++) {
        total += listPenjualanAdmins[i].harga;
      }
      //print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title:
                Text('${widget.pTextTotal}Rp ${numberFormatRp.format(total)}')),
      );
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListAdmin(),
        widgetTextTotalPenjualanAdmin(),
      ],
    );
  }
}
