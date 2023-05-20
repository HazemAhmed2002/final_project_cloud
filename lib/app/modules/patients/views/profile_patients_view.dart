import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common_widget/custom_text.dart';

class ProfilePatientsView extends GetView<LayoutPatientsAppController> {
  ProfilePatientsView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('${patientsAccountModel?.image}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              CustomSizeBox(
                20,
              ),
              Column(
                children: [
                  CustomText(Colors.black, 20, FontWeight.w600,
                      "${patientsAccountModel?.name}"),
                  CustomText(Colors.grey, 14, FontWeight.w400,
                      "${patientsAccountModel?.bio}"),
                  CustomSizeBox(
                    10,
                  ),
                  Row(
                    children: [
                      CustomSizeBox(
                        0,
                        width: 5,
                      ),
                      Expanded(
                        child: customOutlineButtom(
                            const Icon(Icons.edit, color: Colors.green), () {
                          controller.getPatientsData();
                          loginController
                              .moveBetweenPages('UpdateProfilePatientsView');
                        }),
                      ),
                      CustomSizeBox(
                        0,
                        width: 5,
                      ),
                      Expanded(
                          child: customOutlineButtom(
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.green,
                              ), () {
                        GetStorage().remove("tokenOfPatients").then((value) {
                          loginController
                              .moveBetweenPages('SelectionDoctorOrSickView');
                        });
                      })),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}
