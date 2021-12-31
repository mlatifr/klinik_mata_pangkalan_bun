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
    setState(() {
      secondsToDisplay = newSeconds;
    });
  }

  @override
  void initState() {
    widget.stream.listen((seconds) {
      _updateSeconds(seconds);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      secondsToDisplay.toString(),
      textScaleFactor: 5.0,
    );
  }
}
