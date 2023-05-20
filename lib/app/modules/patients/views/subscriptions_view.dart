import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/patients/controllers/article_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SubscriptionsView extends GetView<LayoutPatientsAppController> {
  SubscriptionsView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller) {
        return Scaffold(
          body: controller.subsriptions.isEmpty
              ? Center(child: const Text("لا يوجد اشتراكات"))
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Padding(
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
                                  ArticleController article =
                                      ArticleController();
                                  article.getAllArticle(
                                      controller.categories[index].id);
                                  loginController.moveBetweenPages(
                                      'ArticleView',
                                      arguments: {
                                        "nameCategories": controller
                                            .categories[index].nameCategories,
                                        "id": controller.categories[index].id,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${controller.subsriptions[index].imageCategories}"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    CustomSizeBox(
                                      0,
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            Colors.black,
                                            20,
                                            FontWeight.w600,
                                            "${controller.subsriptions[index].nameCategories}"),
                                        CustomSizeBox(10),
                                        CustomText(
                                            Colors.grey,
                                            12,
                                            FontWeight.w400,
                                            "${controller.subsriptions[index].detailsCategories}"),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: customCircleAvatar(20,
                                          color: controller.subsriptions[index]
                                                      .like ==
                                                  false
                                              ? Colors.grey
                                              : Colors.green,
                                          widget: const Icon(
                                            Icons.star,
                                            color: Colors.white,
                                          ), onTap: () {
                                        controller.updateCategories(controller
                                            .subsriptions[index]
                                            .idOfMyCategories);
                                        print("omar");
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  separatorBuilder: (controller, index) => CustomSizeBox(20),
                  itemCount: controller.subsriptions.length),
        );
      },
    );
  }
}
