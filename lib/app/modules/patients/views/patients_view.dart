import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:test_project/common_widget/custom_buttom.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:test_project/common_widget/custom_text_buttom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_text_form.dart';
import '../controllers/patients_controller.dart';

class PatientsView extends GetView<PatientsController> {
  PatientsView({Key? key}) : super(key: key);
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(Colors.black, 30, FontWeight.w600,
                        "تسجبل الدخول كمريض"),
                  ],
                ),
                CustomSizeBox(50),
                CustomTextForm(email, "الرجاء ادخال بريدك الالكتروني",
                    TextInputType.emailAddress, validator: (email) {
                  if (email!.isEmpty) {
                    return "بريد الالكتروني  لا يجب ان  يكون فارغ";
                  }
                }),
                CustomSizeBox(
                  25,
                ),
                CustomTextForm(password, "الرجاء ادخال كلمة المرور",
                    TextInputType.visiblePassword, validator: (password) {
                  if (password!.isEmpty) {
                    return " كلمة المرور لا يجب ان  يكون فارغ";
                  }
                }),
                CustomSizeBox(
                  50,
                ),
                CustomButtom(() {
                  if (formKey.currentState!.validate()) {
                    controller.login(email.text, password.text);
                  }
                }, Colors.green, 50, double.infinity, 10, Colors.white,
                    "تسجبل الدخول", 15),
                CustomSizeBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextButtom(
                      () {
                        loginController.moveBetweenPages('Register_PATIENTS');
                      },
                      "انشاء حساب",
                      Colors.green,
                      12,
                      FontWeight.w600,
                    ),
                    CustomText(Colors.black, 12, FontWeight.w600,
                        "لم استخدم التطبيق إلى الآن؟"),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
