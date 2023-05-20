import 'dart:io';

import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/update_article_controller.dart';
import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_buttom.dart';
import 'profile_view.dart';

class UpdateArticleView extends GetView<UpdateArticleController> {
  UpdateArticleView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var articleName = TextEditingController();
  var articleDetails = TextEditingController();

  var argument = Get.arguments;
  @override
  Widget build(BuildContext context) {
    articleName.text = argument['name'];
    articleDetails.text = argument['details'];

    print(argument['id']);
    print(argument['idOfArticle']);

    return GetBuilder<UpdateArticleController>(
      init: UpdateArticleController(),
      builder: (controller) {
        return Scaffold(
            body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  controller.imageArticle != null
                      ? Image.file(File(controller.imageArticle!.path))
                      : Image(
                          image: NetworkImage("${argument['image']}"),
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 60),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            loginController.moveBetweenPages('AddArticleView',
                                arguments: {
                                  "id": argument['id'],
                                  "nameCategories": argument['nameCategories']
                                });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customCircleAvatar(18,
                              color: Colors.green,
                              widget: const Icon(Icons.camera), onTap: () {
                            controller.getImage();
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomSizeBox(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextForm(
                          articleName, "Article Name", TextInputType.text,
                          validator: (articleName) {
                        if (articleName!.isEmpty) {
                          return "Article Name mustn't be empty";
                        }
                      }),
                      CustomSizeBox(15),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFfafafa),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          maxLines: 7,
                          controller: articleDetails,
                          keyboardType: TextInputType.text,
                          validator: (validator) {
                            if (validator!.isEmpty) {
                              return "Article details mustn't be empty";
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15),
                            hintText: "Article details",
                            hintStyle: TextStyle(color: Color(0xFFeb6b7bb)),
                          ),
                        ),
                      ),
                      CustomSizeBox(15),
                      CustomButtom(() {
                        if (formKey.currentState!.validate()) {
                          controller
                              .updateArticle(
                                  articleName.text,
                                  articleDetails.text,
                                  controller.valueOfImage,
                                  argument['id'],
                                  argument['idOfArticle'])
                              .then((value) {
                            loginController.moveBetweenPages('AddArticleView',
                                arguments: {
                                  "id": argument['id'],
                                  "nameCategories": argument['nameCategories']
                                });
                          });
                        }
                      }, Colors.green, 50, double.infinity, 10, Colors.white,
                          "Continue", 15)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
