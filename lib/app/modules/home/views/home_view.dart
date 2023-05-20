import 'package:test_project/app/modules/home/controllers/add_article_controller.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_buttom.dart';
import '../../../../common_widget/custom_text.dart';
import '../../../../common_widget/custom_text_form.dart';

class HomeView extends GetView<LayoutController> {
  HomeView({Key? key}) : super(key: key);
  var nameCategories = TextEditingController();
  var detailsCategories = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                controller.changeValueOfBottomSheet(true);
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: List.generate(
                    controller.categories.length,
                    (index) => GestureDetector(
                          onTap: () {
                            AddArticleController article =
                                AddArticleController();
                            LayoutController layoutController =
                                LayoutController();
                            layoutController.changeValueOfIndex(1);
                            article
                                .getAllArticle(controller.categories[index].id)
                                .then((value) {
                              loginController.moveBetweenPages('AddArticleView',
                                  arguments: {
                                    "nameCategories": controller
                                        .categories[index].nameCategories,
                                    "id": controller.categories[index].id,
                                  });
                            });
                          },
                          child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFfafafa),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                    //                   CustomText(Colors.grey,12,FontWeight.w400,"${controller.categories[index].detailsCategories}"),
                                    //
                                  ],
                                ),
                              )),
                        )),
              ),
            ),
            bottomSheet: controller.bottomSheet == true
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 20000),
                    curve: Curves.slowMiddle,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                      child: BottomSheet(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          onClosing: () {},
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 40),
                                child: Form(
                                  key: formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.getImage();
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 2)),
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                        CustomSizeBox(
                                          20,
                                        ),
                                        CustomTextForm(nameCategories,
                                            "اسم الفئة", TextInputType.text,
                                            validator: (nameCategories) {
                                          if (nameCategories!.isEmpty) {
                                            return "اسم الفئة لا يجب ان  يكون فارغ";
                                          }
                                        }),
                                        CustomSizeBox(15),
                                        CustomTextForm(detailsCategories,
                                            "تفاصيل الفئة", TextInputType.text,
                                            validator: (detailsCategories) {
                                          if (detailsCategories!.isEmpty) {
                                            return " تفاصيل الفئة لا يجب ان  يكون فارغ";
                                          }
                                        }),
                                        CustomSizeBox(15),
                                        CustomButtom(() {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller
                                                .addCategories(
                                                    nameCategories.text,
                                                    detailsCategories.text,
                                                    controller.valueOfImage)
                                                .then((value) {
                                              Future.delayed(Duration(
                                                      milliseconds: 500))
                                                  .then((value) {
                                                nameCategories.clear();
                                                detailsCategories.clear();
                                              });
                                            });
                                          }
                                        }, Colors.green, 50, double.infinity,
                                            10, Colors.white, "Continue", 15),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  )
                : null);
      },
    );
  }
}
