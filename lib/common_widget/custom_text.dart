import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? text;
  void Function()? onTap;
  CustomText(this.color, this.fontSize, this.fontWeight, this.text,
      {this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          text!,
          style: TextStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: color),
        ));
  }
}
