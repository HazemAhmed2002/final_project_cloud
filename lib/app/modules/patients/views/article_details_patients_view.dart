import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/patients/controllers/article_details_patients_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ArticleDetailsPatientsView
    extends GetView<ArticleDetailsPatientsController> {
  ArticleDetailsPatientsView({Key? key}) : super(key: key);
  LoginController login = LoginController();

  var argument = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleDetailsPatientsController>(
      init: ArticleDetailsPatientsController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage("${argument['image']}"),
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 60),
                  child: GestureDetector(
                    onTap: () {
                      login.moveBetweenPages('ArticleView', arguments: {
                        'id': argument['id'],
                        'nameCategories': argument['nameCategories'],
                      });
                    },
                    child: Container(
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomSizeBox(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  CustomText(Colors.black, 20, FontWeight.w600,
                      "Name/ ${argument['name']}"),
                  CustomSizeBox(20),
                  CustomText(Colors.black, 20, FontWeight.w600,
                      "Details : \n${argument['details']}"),
                ],
              ),
            ),
          ],
        ));
      },
    );
  }
}
