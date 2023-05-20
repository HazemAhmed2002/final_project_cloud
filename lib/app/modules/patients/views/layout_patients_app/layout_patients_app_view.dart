import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LayoutPatientsAppView extends GetView<LayoutPatientsAppController> {
  const LayoutPatientsAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getAllCategories();
    controller.getAllAccountDoctors();
    controller.getAllSubsriptions();

    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            centerTitle: false,
            title: Row(
              children: [
                const Spacer(),
                CustomText(Colors.black, 20, FontWeight.w600,
                    controller.titleOfPatientsScreen[indexPatients]),
              ],
            ),
          ),
          body: controller.screenPatients[indexPatients],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            currentIndex: indexPatients,
            onTap: (index) {
              controller.changeValueOfIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الصفحة الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'الدردشات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'الاشتراكات',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "الملف الشخصي"),
            ],
          ),
        );
      },
    );
  }
}
