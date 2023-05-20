import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/article_model.dart';
import 'package:get/get.dart';

bool valueOfHomePatients = false;
bool valueOfChatPatients = false;

class ArticleController extends GetxController {
  //TODO: Implement ArticleController

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

  void changevalueOfHomePatients(value) {
    valueOfHomePatients = value;
    print('valueOfHome is $valueOfHomePatients');
    update();
  }

  ArticleModel? articleModel;
  List<ArticleModel> article = [];
  void getAllArticle(idOfCategories) {
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
    });
    update();
  }
}
