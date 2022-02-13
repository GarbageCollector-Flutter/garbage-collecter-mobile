import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MultiPurposeCard extends StatefulWidget {
  Widget? rightTopCorner;
  Widget? title;
  Widget? body;
  Future<void> Function()? onRefresh;

  MultiPurposeCard(
      {Key? key, this.rightTopCorner, this.title, this.body, this.onRefresh})
      : super(key: key);

  @override
  _MultiPurposeCardState createState() => _MultiPurposeCardState();
}

class _MultiPurposeCardState extends State<MultiPurposeCard> {
  final BoxDecoration boxDecoration = BoxDecoration(
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
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(minHeight: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title ?? Container(),
                widget.rightTopCorner ?? Container()
              ],
            ),
          ),
          const Divider(
            color: Colors.black45,
          ),
          widget.onRefresh != null
              ? RefreshIndicator(
                  child: widget.body ?? Container(),
                  onRefresh: widget.onRefresh!)
              : widget.body ?? Container(),
          
        ],
      ),
    );
  }
}
