import 'package:test_project/app/modules/home/controllers/selection_doctor_or_sick_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionDoctorOrSickView
    extends GetView<PageSelectionDoctorOrSickController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("omar");
    });

    return GetBuilder<PageSelectionDoctorOrSickController>(
      init: PageSelectionDoctorOrSickController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/cloud.jpg',
                ),
                containerOfDoctorOrSick(() {
                  controller.changeValue(false);
                }, "طبيب", Icons.person),
                CustomSizeBox(20),
                containerOfDoctorOrSick(() {
                  controller.changeValue(true);
                }, "مريض", Icons.person),
              ],
            ),
          ),
        );
      },
    );
  }

  containerOfDoctorOrSick(
          void Function() onTap, String text, IconData iconData) =>
      Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(Colors.white, 18, FontWeight.w600, text),
              CustomSizeBox(
                0,
                width: 10,
              ),
              Icon(
                iconData,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
}
