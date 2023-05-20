import 'package:flutter/material.dart';

class CustomTextButtom extends StatelessWidget {
  void Function()? onPressed;
  String? text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  CustomTextButtom(
      this.onPressed, this.text, this.color, this.fontSize, this.fontWeight);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(
              color: color, fontSize: fontSize, fontWeight: fontWeight),
        ));
  }
}
