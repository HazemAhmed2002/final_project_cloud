import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widget/custom_text.dart';

class LayoutView extends GetView<LayoutController> {
  @override
  Widget build(BuildContext context) {
    controller.getAllCategories();
    controller.getAllAccountPatients();

    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Row(
              children: [
                Spacer(),
                CustomText(Colors.black, 20, FontWeight.w600,
                    controller.titleOfScreen[index]),
              ],
            ),
            actions: const [],
          ),
          body: controller.screen[index],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            currentIndex: index,
            onTap: (index) {
              controller.changeValueOfIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'الصفحة الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message_outlined,
                ),
                label: 'الدردشات',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none,
                ),
                label: 'الاشعارات',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "الملف الشخصي"),
            ],
            selectedLabelStyle: const TextStyle(
              color: Colors.green, // change this to the desired color
            ),
          ),
        );
      },
    );
  }
}
