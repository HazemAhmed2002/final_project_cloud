import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  IconData? preIcon;
  IconData? suffixIcon;
  TextInputType? textInputType;
  FormFieldValidator<String>? validator;
  CustomTextForm(this.controller, this.hintText, this.textInputType,
      {this.preIcon, this.suffixIcon, this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFfafafa),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: validator,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFeb6b7bb)),
          prefixIcon: this.preIcon != null
              ? Icon(
                  preIcon,
                  color: const Color(0xFFeb6b7bb),
                )
              : null,
          suffixIcon: this.suffixIcon != null
              ? Icon(
                  suffixIcon,
                  color: const Color(0xFFeb6b7bb),
                )
              : null,
        ),
      ),
    );
  }
}
