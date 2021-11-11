import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_fetch_penjualan_nota.dart';
import 'package:intl/intl.dart';

class WidgetAkunJasmed extends StatefulWidget {
  const WidgetAkunJasmed({Key key}) : super(key: key);

  @override
  _WidgetAkunJasmedState createState() => _WidgetAkunJasmedState();
}

class _WidgetAkunJasmedState extends State<WidgetAkunJasmed> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetListJasmed() {
    if (ListPenjualanJasmeds.length > 0) {
      return ExpansionTile(title: Text('Daftar Penjualan Jasmed'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ListPenjualanJasmeds.length,
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
                      title: Text('${ListPenjualanJasmeds[index].nama_pasien}'),
                      subtitle: Text(
                          '${ListPenjualanJasmeds[index].tgl_resep} \nRp ${numberFormatRp.format(ListPenjualanJasmeds[index].harga)}'),
                    ),
                  ));
            }),
      ]);
    } else
      return Container();
  }

  Widget widgetTextTotalPenjualanJasmed() {
    int total = 0;
    if (ListPenjualanJasmeds.length > 0) {
      print('ListPenjualanJasmed.length: ${ListPenjualanJasmeds.length}');
      for (var i = 0; i < ListPenjualanJasmeds.length; i++) {
        total += ListPenjualanJasmeds[i].harga;
      }
      print(total.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
                'Total Penjualan Jasmed Rp ${numberFormatRp.format(total)}')),
      );
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetListJasmed(),
        widgetTextTotalPenjualanJasmed(),
      ],
    );
  }
}