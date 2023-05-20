import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  void Function()? onPressed;
  Color? color;
  double? height;
  double? width;
  double? raduis;
  Color? textColor;
  String? text;
  double? fontSize;
  CustomButtom(this.onPressed, this.color, this.height, this.width, this.raduis,
      this.textColor, this.text, this.fontSize);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis!),
          color: color,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          height: height,
          child: Text(
            text!,
            style: TextStyle(fontSize: fontSize, color: textColor),
          ),
        ));
  }
}
