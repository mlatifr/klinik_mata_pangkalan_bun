import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_HPP_obat.dart'
    as akunHPPObat;
import 'package:flutter_application_1/akuntan/page_nota/akuntan_page_akun_obat.dart'
    as akunObat;

class WidgetLabaKotor extends StatefulWidget {
  WidgetLabaKotor({
    Key key,
  }) : super(key: key);

  @override
  _WidgetLabaKotorState createState() => _WidgetLabaKotorState();
}

class _WidgetLabaKotorState extends State<WidgetLabaKotor> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
  Widget widgetTextLabarKotor(pPenjualan, pHPP) {
    int labaKotor = 0;
    labaKotor = pPenjualan - pHPP;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text('Laba Kotor: Rp ${numberFormatRp.format(labaKotor)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetTextLabarKotor(akunObat.totalPenjualan, akunHPPObat.totalHPPObat),
      ],
    );
  }
}
