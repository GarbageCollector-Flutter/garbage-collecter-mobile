import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CancelButton extends StatefulWidget {
  Function onTap;
  Size size;
  Widget? child;
  CancelButton({Key? key, required this.onTap,required this.size,this.child}) : super(key: key);

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.redAccent,
        ),
          foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        fixedSize: MaterialStateProperty.all<Size>(widget.size),
      ),
      onPressed:()=>widget.onTap(),
      child:widget.child?? const Text("iptal",style: TextStyle(fontSize: 25),),
    );
  }
}
