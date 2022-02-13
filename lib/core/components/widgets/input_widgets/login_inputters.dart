import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginInputters extends StatefulWidget {
  TextEditingController? controller;
  TextInputType? textInputType;
  FocusNode? focusNode;
  LoginInputters({Key? key,this.controller,this.focusNode,this.textInputType}) : super(key: key);

  @override
  _LoginInputtersState createState() => _LoginInputtersState();
}

class _LoginInputtersState extends State<LoginInputters> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      smartDashesType: SmartDashesType.disabled,
        controller: widget.controller,
        key: widget.key,
        focusNode: widget.focusNode,

        cursorColor: Colors.black,
        cursorRadius: const Radius.circular(45),
        keyboardType: widget.textInputType ??TextInputType.phone,
        autofocus: false,
        style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.black),
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          errorText: null,
          contentPadding: const EdgeInsets.only(
              left: 20, right: 20,top: 15),
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0)),
        ),
      );
  }
}