// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButon extends StatefulWidget {
  final String text;
  TextButon({Key? key,required this.text}) : super(key: key);

  @override
  _TextButonState createState() => _TextButonState();
}

class _TextButonState extends State<TextButon> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return  FlatButton(
            
              onPressed: () {  },
              child: Text(
               widget.text,
                style: GoogleFonts.ibmPlexSans(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
              ),
            );
  }
}