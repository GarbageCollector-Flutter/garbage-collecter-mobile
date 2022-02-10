import 'package:first_three/core/extenstions/string_extension.dart';
import 'package:flutter/material.dart';

class LocalText extends StatefulWidget {
  final String value;
  const LocalText({Key? key,required this.value}) : super(key: key);

  @override
  State<LocalText> createState() => _LocalTextState();
}

class _LocalTextState extends State<LocalText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.value.locale);
  }
}