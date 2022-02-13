import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultDialog extends StatefulWidget {
  double? height;
  double? width;
  Widget?title;
  Widget?body;
  List<Widget>? buttons;
  Function? initFun;
  
  DefaultDialog({Key? key,this.width,this.height,this.buttons,this.body,this.title,this.initFun}) : super(key: key);

  @override
  State<DefaultDialog> createState() => _DefaultDialogState();
}

class _DefaultDialogState extends State<DefaultDialog> {
@override
void initState(){
  super.initState();
        if(widget.initFun!=null){
            widget.initFun!(context);
  }

}

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor:Theme.of(context).primaryColorLight,
      child: SizedBox(
      height: widget.height,
      width: widget.width,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [

       widget.title??Container(),
       widget.body??Container(),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children:  widget.buttons??[],)
     ],),
   
      ),
      

    );
  }
}