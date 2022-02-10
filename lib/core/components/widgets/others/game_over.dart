import 'dart:async';

import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatefulWidget {
  int score;
  List<Widget>? buttons;
  GameOver({Key? key, required this.score, this.buttons}) : super(key: key);

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends BaseState<GameOver> {
  Color textColor = Colors.black;
  Color backGroundColor = Colors.red;
  bool flag = false;

  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        if (flag == true) {
          textColor = Colors.white;
          backGroundColor = Colors.red;
          flag = false;
        } else {
          textColor = Colors.red;
          backGroundColor = Colors.white;
          flag = true;
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backGroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
         Expanded(
                    flex: 1,
                    child: Text("score",
                        style: GoogleFonts.audiowide(
                          color: textColor,
                          fontSize: 90,
                        ))),
                         Expanded(
                    flex: 1,
                    child: Text(widget.score.toString(),
                        style: GoogleFonts.audiowide(
                          color: textColor,
                          fontSize: 120,
                        ))),
                           Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.buttons??[],)),
      ]),
    );
  }
}
