import 'package:flutter/material.dart';

class ConfirmButton extends StatefulWidget {
  Function onTap;
    Size size;
    Widget child;
 ConfirmButton({Key? key,required this.onTap,required this.size,required this.child}) : super(key: key);

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
          foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        fixedSize: MaterialStateProperty.all<Size>(widget.size),
      ),
      onPressed:()=>widget.onTap(),
      child:widget.child,
    );
  }
}