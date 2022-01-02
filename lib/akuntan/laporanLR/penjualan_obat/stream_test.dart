import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetStream extends StatefulWidget {
  final Stream<int> stream;
  WidgetStream({Key key, this.stream}) : super(key: key);

  @override
  _WidgetStreamState createState() => _WidgetStreamState();
}

class _WidgetStreamState extends State<WidgetStream> {
  int secondsToDisplay = 0;

  void _updateSeconds(int newSeconds) {
    print('proses 3');
    setState(() {
      secondsToDisplay = newSeconds;
      print('proses 4');
    });
  }

  @override
  void initState() {
    widget.stream.listen((seconds) {
      print('proses 2');
      _updateSeconds(seconds);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('proses 5');
    return Text(
      secondsToDisplay.toString(),
      textScaleFactor: 5.0,
    );
  }
}
