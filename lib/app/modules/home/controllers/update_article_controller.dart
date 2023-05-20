// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/article_model.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateArticleController extends GetxController {
  //TODO: Implement UpdateArticleController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var picker = ImagePicker();
  File? imageArticle;

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageArticle = File(pickedFile.path);
      print(imageArticle!.path);
      uploadImage();
      update();
    } else {
      print('No image selected.');
    }
  }

  String valueOfImage = '';
  void uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'updateArticle/${Uri.file(imageArticle!.path).pathSegments.last}')
        .putFile(imageArticle!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        valueOfImage = value;
        print("the value is $valueOfImage");
        update();
      }).catchError((error) {});
    }).catchError((error) {});
  }

  ArticleModel? articleModel;
  LoginController loginController = LoginController();
  Future<void> updateArticle(nameArticle, detailsArticle, imageArticle,
      idOfCategories, idOfArticle) async {
    articleModel = ArticleModel(nameArticle, detailsArticle, imageArticle,
        idOfCategories, tokenOfDoctors,
        idOfArticle: idOfArticle);

    FirebaseFirestore.instance
        .collection("Categories")
        .doc(idOfCategories)
        .collection("Article")
        .doc(idOfArticle)
        .update(articleModel?.toMap() ?? {})
        .then((value) {
      valueOfImage = '';

      update();
    });

    update();
  }
}
