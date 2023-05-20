import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/app/modules/patients/controllers/update_profile_patients_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:test_project/common_widget/custom_text_buttom.dart';
import 'package:test_project/common_widget/custom_text_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/controllers/register_controller.dart';

class UpdateProfilePatientsView
    extends GetView<UpdateProfilePatientsController> {
  UpdateProfilePatientsView({Key? key}) : super(key: key);
  var name = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    name.text = patientsAccountModel?.name;
    bio.text = patientsAccountModel?.bio;
    phone.text = patientsAccountModel?.phone;
    return GetBuilder<UpdateProfilePatientsController>(
      init: UpdateProfilePatientsController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        LayoutPatientsAppController layout =
                            LayoutPatientsAppController();
                        layout.changeValueOfIndex(3);
                        loginController
                            .moveBetweenPages('LayoutPatientsAppView');
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      )),
                  CustomSizeBox(
                    0,
                    width: 20,
                  ),
                  CustomText(
                      Colors.black, 18, FontWeight.w600, "تعديل الملف الشخصي"),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextButtom(() {
                    if (formKey.currentState!.validate()) {
                      controller.updatePatientsData(
                          name: name.text, phone: phone.text, bio: bio.text);
                    }
                  }, "تعديل", Colors.green, 15, FontWeight.w400),
                )
              ],
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: controller.profileImage == null
                                        ? NetworkImage(
                                            '${patientsAccountModel?.image}')
                                        : FileImage(controller.profileImage!)
                                            as ImageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customCircleAvatar(18,
                                  color: Colors.green,
                                  widget: Icon(Icons.camera), onTap: () {
                                controller.getProfileImage(
                                    name.text, phone.text, bio.text);
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomSizeBox(
                      20,
                    ),
                    Column(
                      children: [
                        CustomTextForm(
                            name, "الرجاء ادخال اسمك", TextInputType.name,
                            validator: (name) {
                          if (name!.isEmpty) {
                            return "اسمك لا يجب ان  يكون فارغ";
                          }
                        }),
                        CustomSizeBox(10),
                        CustomTextForm(bio, "الرجاء ادخال سبرتك الذاتية",
                            TextInputType.text, validator: (bio) {
                          if (bio!.isEmpty) {
                            return "سبرتك الذاتية لا يجب ان  يكون فارغ";
                          }
                        }),
                        CustomSizeBox(10),
                        CustomTextForm(
                          phone,
                          "الرجاء ادخال رقم الهاتف",
                          TextInputType.phone,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "رقم الهاتف لا يجب ان  يكون فارغ";
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
