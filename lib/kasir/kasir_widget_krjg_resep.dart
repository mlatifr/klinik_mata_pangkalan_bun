import 'package:flutter/material.dart';
import 'package:flutter_application_1/kasir/kasir_detail_pasien.dart';
import 'package:flutter_application_1/kasir/kasir_get_resep.dart';
import 'package:flutter_application_1/kasir/kasir_mengurangi_stok_obat.dart';

class WidgetKrjgRsp extends StatefulWidget {
  const WidgetKrjgRsp({Key key}) : super(key: key);

  @override
  _WidgetKrjgRspState createState() => _WidgetKrjgRspState();
}

class _WidgetKrjgRspState extends State<WidgetKrjgRsp> {
  @override
  Widget build(BuildContext context) {
    hargaKaliObat.clear();
    totalBiayaObat = 0;
    if (kVKRs.length > 0) {
      for (var i = 0; i < kVKRs.length; i++) {
        hargaKaliObat
            .add(int.parse(kVKRs[i].hargaJual) * int.parse(kVKRs[i].jumlah));
        // totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
      }
      for (var i = 0; i < hargaKaliObat.length; i++) {
        // hargaKaliObat.add(KVKRs[i].hargaJual * KVKRs[i].jumlah);
        totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
      }
      return Column(
        children: [
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Nama',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Jumlah',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga Satuan',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga Total',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: kVKRs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          ' $index| ${kVKRs[index].namaObat}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${kVKRs[index].jumlah}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${kVKRs[index].stok}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpResep.format(int.parse(kVKRs[index].hargaJual))}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpResep.format(hargaKaliObat[index])}',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ]);
              }),
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${numberFormatRpResep.format(totalBiayaObat)}',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          ElevatedButton(
              onPressed: () {
                CalculateStokObatBaru();
              },
              child: Text('Calculate'))
        ],
      );
    } else {
      return Row(
        children: [Text('Keranjang Tindakan: '), CircularProgressIndicator()],
      );
    }
  }
}
