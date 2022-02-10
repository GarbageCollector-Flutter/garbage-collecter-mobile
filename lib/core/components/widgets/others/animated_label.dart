// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class AnimetedLabel extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  AnimetedLabel({Key? key, required this.text, required this.textStyle})
      : super(key: key);

  @override
  _AnimetedLabelState createState() => _AnimetedLabelState();
}

class _AnimetedLabelState extends State<AnimetedLabel> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
      style: widget.textStyle,
      child: Text(
        widget.text,
      ),
    );
  }
}
