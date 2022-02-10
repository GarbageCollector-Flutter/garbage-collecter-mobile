import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  final Map<String, Function>? buttons;
  final Widget? title;
  final Widget? lead;
   final Widget? suffix;
  final Function? onChange;
  const MyAppBar({Key? key, this.buttons, this.title, this.lead, this.onChange,this.suffix})
      : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return animatedContainer;
  }

  Widget get animatedContainer => AnimatedContainer(
        width: double.infinity,
        height: _isMenuOpen
            ? widget.buttons != null
                ? widget.buttons!.values.length * 70 + 75
                : 75
            : 75,
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _isMenuOpen ? Colors.grey[300] : Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0.0, 0),
            )
          ],
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              firstDefaultItem,
              if (widget.buttons != null)
                for (var item in widget.buttons!.keys)
                  itemButton(item.toString())
            ],
          ),
        ),
      );

  Widget get firstDefaultItem => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.lead ??
                const SizedBox(
                  width: 0,
                ),
            widget.title ??
                const SizedBox(
                  width: 0,
                ),
            widget.buttons != null
                ? Container(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (widget.onChange != null) {
                          widget.onChange!();
                        }

                        setState(() {
                          _isMenuOpen == false
                              ? _isMenuOpen = true
                              : _isMenuOpen = false;
                        });
                      },
                      child: Icon(Icons.menu,
                          size: 40,
                          color: _isMenuOpen ? Colors.blue : Colors.grey[300]),
                    ),
                  )
                : widget.suffix?? const Text("            ")
          ],
        ),
      );

  Widget itemButton(String text) {
    return GestureDetector(
      onTap: () => widget.buttons![text]!(),
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
