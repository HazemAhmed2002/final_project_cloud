import 'package:test_project/app/modules/home/controllers/add_article_controller.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/common_widget/custom_buttom.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:test_project/common_widget/custom_text_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

bool bottomSheetOfArticle = false;

class AddArticleView extends GetView<AddArticleController> {
  AddArticleView({Key? key}) : super(key: key);
  var argument = Get.arguments;
  var formKey = GlobalKey<FormState>();
  var articleName = TextEditingController();
  LoginController loginController = LoginController();

  var articleDetails = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.getAllArticle('${argument['id']}');

    return GetBuilder<AddArticleController>(
      init: AddArticleController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              controller.changeValueOfBottomSheet(true);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      LayoutController layoutController = LayoutController();
                      layoutController.changeValueOfIndex(0).then((value) {
                        // controller.changevalueOfHome(true);

                        loginController.moveBetweenPages('layout');
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
          body: controller.article.length == 0
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
                              loginController.moveBetweenPages(
                                  'ArticleDetailsView',
                                  arguments: {
                                    "image": controller.article[index].image,
                                    "id": argument['id'],
                                    "idOfArticle":
                                        controller.article[index].idOfArticle,
                                    "nameCategories":
                                        argument['nameCategories'],
                                    "name": controller.article[index].name,
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
                                controller.article[index].tokonofDoctor ==
                                        tokenOfDoctors
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                            onTap: () {
                                              loginController.moveBetweenPages(
                                                  'UpdateArticleView',
                                                  arguments: {
                                                    "image": controller
                                                        .article[index].image,
                                                    "id": argument['id'],
                                                    "idOfArticle": controller
                                                        .article[index]
                                                        .idOfArticle,
                                                    "nameCategories": argument[
                                                        'nameCategories'],
                                                    "name": controller
                                                        .article[index].name,
                                                    "details": controller
                                                        .article[index].details
                                                  });
                                            },
                                            child: Icon(Icons.edit)),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (controller, index) => CustomSizeBox(
                        20,
                      ),
                  itemCount: controller.article.length),
          bottomSheet: controller.bottomSheet == true
              ? Container(
                  height: 400,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color: Colors.green, width: 2)),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                    CustomSizeBox(
                                      20,
                                    ),
                                    CustomTextForm(articleName, "اسم المقالة",
                                        TextInputType.text,
                                        validator: (articleName) {
                                      if (articleName!.isEmpty) {
                                        return "اسم المقالة لا يجب ان  يكون فارغ";
                                      }
                                    }),
                                    CustomSizeBox(15),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFfafafa),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        maxLines: 7,
                                        controller: articleDetails,
                                        keyboardType: TextInputType.text,
                                        validator: (validator) {
                                          if (validator!.isEmpty) {
                                            return "تفاصيل المقالة لا يجب ان  يكون فارغ";
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(left: 15),
                                          hintText: "تفاصيل المقالة",
                                          hintStyle: TextStyle(
                                              color: Color(0xFFeb6b7bb)),
                                        ),
                                      ),
                                    ),
                                    CustomSizeBox(15),
                                    CustomButtom(() {
                                      if (formKey.currentState!.validate()) {
                                        controller
                                            .addArticle(
                                                articleName.text,
                                                articleDetails.text,
                                                controller.valueOfImage,
                                                argument['id'])
                                            .then((value) {});
                                      }
                                    }, Colors.green, 50, double.infinity, 10,
                                        Colors.white, "Continue", 15),
                                  ],
                                ),
                              ),
                            ),
                          )),
                )
              : null,
        );
      },
    );
  }
}
