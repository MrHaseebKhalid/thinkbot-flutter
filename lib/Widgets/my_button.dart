import "package:flutter/material.dart";

import "../Base/Resizer/fetch_pixels.dart";
import "../Resources/resources.dart";

class MyButton extends StatefulWidget {
  final String buttonText;
  final GestureTapCallback onTap;

  const MyButton({super.key, required this.buttonText, required this.onTap});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FetchPixels.getPixelHeight(55),
      width: FetchPixels.getPixelWidth(350),
      color: R.colors.transparent,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) async {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (details) async {
          await Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              _isPressed = false;
            });
          });
        },
        onTapCancel: () async {
          await Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              _isPressed = false;
            });
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: FetchPixels.getPixelWidth((_isPressed) ? 310 : 320),
          height: FetchPixels.getPixelHeight((_isPressed) ? 42.75 : 45),
          decoration: BoxDecoration(
            color: (_isPressed) ? R.colors.whiteColor : R.colors.buttonColor,
            borderRadius: BorderRadius.circular(
              FetchPixels.getPixelHeight(8.0),
            ),
            shape: BoxShape.rectangle,
          ),
          alignment: Alignment.center,
          child: Text(
            widget.buttonText,
            textScaler: TextScaler.linear(FetchPixels.getTextScale()),
            style: R.textStyle.boldRobotoDisplay().copyWith(
              fontSize: 18,
              color: R.colors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
