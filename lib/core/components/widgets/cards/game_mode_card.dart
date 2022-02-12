import 'package:flutter/material.dart';

class GameModeCard extends StatefulWidget {
  final Widget icon;
  final String firstTitle;
  final String subTitle;
  final Function onTap;
  final double maxHeight;
  final double maxWidth;

  const GameModeCard({
    Key? key,
    required this.icon,
    required this.firstTitle,
    required this.subTitle,
    required this.onTap,required this.maxHeight,required this.maxWidth,
  }) : super(key: key);

  @override
  _GameModeCardState createState() => _GameModeCardState();
}

class _GameModeCardState extends State<GameModeCard> {
  BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0.0, 5),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        constraints: BoxConstraints(maxHeight:widget.maxHeight ,maxWidth:widget.maxWidth),
        padding: const EdgeInsets.all(10),
          decoration: boxDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 300,
                width: 180,
                child: widget.icon,
              ),
              const VerticalDivider(
                color: Colors.black,
                width: 20,
                indent: 20,
                endIndent: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 140,
                    child: Text(
                      widget.firstTitle,
                      overflow: TextOverflow.fade,
                        maxLines: 1,
                      softWrap: false,
                      style:const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    widget.subTitle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
               
                ],
              ),   Image.asset(
                    'assets/card_icons/greater_than.png',
                    color: Colors.black38,
                    height: 30,
                    width: 30,
                  )
            ],
          )),
    );
  }
}
