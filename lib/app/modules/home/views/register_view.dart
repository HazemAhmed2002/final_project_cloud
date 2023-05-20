import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/common_widget/custom_buttom.dart';
import 'package:test_project/common_widget/custom_text_buttom.dart';
import 'package:test_project/common_widget/custom_text_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_size_box.dart';
import '../../../../common_widget/custom_text.dart';

LoginController loginController = Get.put(LoginController());

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(Colors.black, 30, FontWeight.w600,
                      "هيا بنا ننشأ حساب طبيب"),
                  CustomSizeBox(
                    50,
                  ),
                  CustomTextForm(name, "الرجاء ادخال اسمك", TextInputType.name,
                      validator: (name) {
                    if (name!.isEmpty) {
                      return "اسمك لا يجب ان  يكون فارغ";
                    }
                  }),
                  CustomSizeBox(
                    25,
                  ),
                  CustomTextForm(email, "الرجاء ادخال بريدك الالكتروني",
                      TextInputType.emailAddress, validator: (email) {
                    if (email!.isEmpty) {
                      return "بريد الالكتروني  لا يجب ان  يكون فارغ";
                    }
                  }),
                  CustomSizeBox(
                    25,
                  ),
                  CustomTextForm(
                      phone, "الرجاء ادخال رقم الهاتف", TextInputType.phone,
                      validator: (phoneNumber) {
                    if (phoneNumber!.isEmpty) {
                      return "رقم الهاتف لا يجب ان  يكون فارغ";
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
                      controller.register(
                          email.text, password.text, name.text, phone.text);
                    }
                  }, Colors.green, 50, double.infinity, 10, Colors.white,
                      "الاستمرار", 15),
                  CustomSizeBox(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextButtom(
                        () {
                          loginController.moveBetweenPages('login');
                        },
                        "تسجبل الدخول",
                        Colors.green,
                        12,
                        FontWeight.w600,
                      ),
                      CustomText(
                          Colors.black, 12, FontWeight.w600, "هل لديك حساب؟"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
