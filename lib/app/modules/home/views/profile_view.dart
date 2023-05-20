import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileView extends GetView<LayoutController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (Controller) {
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
                          image: NetworkImage('${doctorAccountModel?.image}'),
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
                      "${doctorAccountModel?.name}"),
                  CustomText(Colors.grey, 14, FontWeight.w400,
                      "${doctorAccountModel?.bio}"),
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
                            Icon(
                              Icons.edit,
                              color: Colors.green,
                            ), () {
                          controller.getDoctorsData();
                          loginController.moveBetweenPages('UpdateProfileView');
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
                        GetStorage().remove("token").then((value) {
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

Widget customCircleAvatar(double raduis,
        {Color? color,
        String? image,
        Widget? widget,
        void Function()? onTap}) =>
    GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          child: widget,
          radius: raduis,
          backgroundColor: color,
          backgroundImage: NetworkImage(image ?? ""),
        ));
Widget customOutlineButtom(Widget widget, void Function() onPressed) =>
    OutlinedButton(onPressed: onPressed, child: widget);
