import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/patients/controllers/article_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/layout_patients_app_controller.dart';

class HomePatientsView extends GetView<LayoutPatientsAppController> {
  HomePatientsView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: controller.categories.length == 0
                ? Center(child: Text("Three is no categories"))
                : GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: List.generate(
                        controller.categories.length,
                        (index) => GestureDetector(
                              onTap: () {
                                ArticleController article = ArticleController();
                                article.getAllArticle(
                                    controller.categories[index].id);
                                loginController.moveBetweenPages('ArticleView',
                                    arguments: {
                                      "nameCategories": controller
                                          .categories[index].nameCategories,
                                      "id": controller.categories[index].id,
                                    });
                              },
                              child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFfafafa),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                height: 85,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${controller.categories[index].imageCategories}"),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: customCircleAvatar(20,
                                                  color: controller
                                                              .categories[index]
                                                              .like ==
                                                          false
                                                      ? Colors.grey
                                                      : Colors.green,
                                                  widget: Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ), onTap: () {
                                                print("object");
                                                controller.updateCategories(
                                                    controller.categories[index]
                                                        .idOfMyCategories);
                                              }),
                                            )
                                          ],
                                        ),
                                        CustomSizeBox(10),

                                        CustomText(
                                            Colors.black,
                                            20,
                                            FontWeight.w600,
                                            "${controller.categories[index].nameCategories}"),
                                        CustomSizeBox(10),
                                        //
                                        CustomText(
                                            Colors.grey,
                                            12,
                                            FontWeight.w400,
                                            "${controller.categories[index].detailsCategories}"),
                                        //
                                      ],
                                    ),
                                  )),
                            )),
                  ),
          ),
        );
      },
    );
  }
}
