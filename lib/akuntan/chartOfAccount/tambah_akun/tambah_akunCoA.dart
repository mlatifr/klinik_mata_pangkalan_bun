import 'package:flutter/material.dart';

class TambahAkunCoA extends StatefulWidget {
  const TambahAkunCoA({Key key}) : super(key: key);

  @override
  State<TambahAkunCoA> createState() => _TambahAkunCoAState();
}

class _TambahAkunCoAState extends State<TambahAkunCoA> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Tambah Akun CoA'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
