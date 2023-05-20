import 'package:test_project/app/modules/patients/controllers/article_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/controllers/login_controller.dart';
import '../controllers/layout_patients_app_controller.dart';

class ArticleView extends GetView<ArticleController> {
  ArticleView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();
  var argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.getAllArticle("${argument['id']}");
    return GetBuilder<ArticleController>(
      init: ArticleController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      LayoutPatientsAppController layout =
                          LayoutPatientsAppController();
// controller.changevalueOfHomePatients(true);
// layout.getAllCategories().then((value) {
                      loginController.moveBetweenPages('LayoutPatientsAppView');

// });
                      controller.changevalueOfHomePatients(true);
                      layout.getAllCategories().then((value) {
                        loginController
                            .moveBetweenPages('LayoutPatientsAppView');
                      });
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                    )),
                CustomSizeBox(
                  0,
                  width: 20,
                ),
                CustomSizeBox(
                  0,
                  width: 10,
                ),
                CustomText(Colors.black, 20, FontWeight.w600,
                    "${argument['nameCategories']}"),
              ],
            ),
          ),
          body: controller.article.isEmpty
              ? Container()
              : ListView.separated(
                  itemBuilder: (controllers, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFfafafa),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              LoginController loginController =
                                  LoginController();
                              loginController.moveBetweenPages(
                                  'ArticleDetailsPatientsView',
                                  arguments: {
                                    "image": controller.article[index].image,
                                    "name": controller.article[index].name,
                                    "nameCategories":
                                        argument['nameCategories'],
                                    "id": argument['id'],
                                    "details": controller.article[index].details
                                  });
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${controller.article[index].image}"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                CustomSizeBox(
                                  0,
                                  width: 20,
                                ),
                                CustomText(Colors.black, 20, FontWeight.w600,
                                    "${controller.article[index].name}"),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (controller, index) => CustomSizeBox(
                        20,
                      ),
                  itemCount: controller.article.length),
        );
      },
    );
  }
}
