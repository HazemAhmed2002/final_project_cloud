import 'package:flutter/material.dart';

class CustomSizeBox extends StatelessWidget {
  double? height;
  double? width;
  CustomSizeBox(this.height, {this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? 0,
    );
  }
}
