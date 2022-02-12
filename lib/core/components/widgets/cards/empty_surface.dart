import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptySurface extends StatefulWidget {
  Widget child;
  EmptySurface({Key? key,required this.child}) : super(key: key);

  @override
  State<EmptySurface> createState() => _EmptySurfaceState();
}

class _EmptySurfaceState extends State<EmptySurface> {
  @override
  Widget build(BuildContext context) {
    return Container(
  
      
       margin: const EdgeInsets.all(10),
       padding: const EdgeInsets.all(10),
       decoration :BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: widget.child,
    );
  }
}