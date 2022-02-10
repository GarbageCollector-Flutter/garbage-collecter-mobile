// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignButton extends StatefulWidget {
  final String text;
  Function()? onTap;
  SignButton({Key? key, required this.text,this.onTap}) : super(key: key);

  @override
  _SignButtonState createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 2.0,
          spreadRadius: 0.1,
          offset: Offset(0.1, 0.1), // shadow direction: bottom right
        )
      ], borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color:Theme.of(context).primaryColor ,
        child: InkWell(
          highlightColor: Colors.black54,
          onTap:widget.onTap,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              child: Text(widget.text, style: GoogleFonts.josefinSans(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),)),
        ),
      ),
    );
  }
}
