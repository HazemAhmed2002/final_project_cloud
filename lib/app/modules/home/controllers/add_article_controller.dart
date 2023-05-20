import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/article_model.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/app/modules/home/views/add_article_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

bool valueOfHome = false;

class AddArticleController extends GetxController {
  //TODO: Implement AddArticleController
  bool bottomSheet = false;
  void changeValueOfBottomSheet(bool value) {
    bottomSheet = value;

    update();
  }

  void changevalueOfHome(value) {
    valueOfHome = value;
    print('valueOfHome is $valueOfHome');
    update();
  }

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

  String? valueOfImage;
  void uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Article/${Uri.file(imageArticle!.path).pathSegments.last}')
        .putFile(imageArticle!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        valueOfImage = value;
        print("the value is $valueOfImage");
        update();
      }).catchError((error) {});
      update();
    }).catchError((error) {});
  }

  ArticleModel? articleModel;
  List<ArticleModel> article = [];
  Future<void> getAllArticle(idOfCategories) async {
    article = [];
    FirebaseFirestore.instance
        .collection("Categories")
        .doc("$idOfCategories")
        .collection("Article")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        article.add(ArticleModel.fromJson(element.data()));
        update();
      });
      update();
    });
    update();
  }

  Future<void> addArticle(
      nameArticle, detailsArticle, imageArticle, idOfCategories) async {
    articleModel = ArticleModel(nameArticle, detailsArticle, imageArticle,
        idOfCategories, tokenOfDoctors);
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      FirebaseFirestore.instance
          .collection("Categories")
          .doc("$idOfCategories")
          .collection("Article")
          .add(articleModel?.toMap() ?? {})
          .then((value) {
        articleModel = ArticleModel(nameArticle, detailsArticle, imageArticle,
            idOfCategories, tokenOfDoctors,
            idOfArticle: value.id);
        update();
        FirebaseFirestore.instance
            .collection("Categories")
            .doc("$idOfCategories")
            .collection("Article")
            .doc(value.id)
            .update(articleModel?.toMap() ?? {})
            .then((value) {
          getAllArticle(idOfCategories);
          changeValueOfBottomSheet(false);
          update();
        });

        update();
      }).catchError((error) {});
      update();
    });

    update();
  }

  void changeValueOfBottomSheetOfArticle(value) {
    bottomSheetOfArticle = value;
    update();
  }
}
