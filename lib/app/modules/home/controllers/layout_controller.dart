import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/categories_model.dart';
import 'package:test_project/app/data/patients_account_model.dart';
import 'package:test_project/app/modules/home/controllers/add_article_controller.dart';
import 'package:test_project/app/modules/home/controllers/group_chat_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/app/modules/home/views/chat_view.dart';
import 'package:test_project/app/modules/home/views/home_view.dart';
import 'package:test_project/app/modules/home/views/notifications_view.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../data/doctor_account_model.dart';
import '../../../data/message_model.dart';

var index = 0;
List<PatientsAccountModel> patients = [];
DoctorAccountModel? doctorAccountModel;
AddArticleController addArticleController = AddArticleController();
GroupChatController groupChatController = GroupChatController();

class LayoutController extends GetxController {
  bool bottomSheet = false;
  List screen = [
    HomeView(),
    ChatView(),
    NotificationsView(),
    ProfileView(),
  ];
  List titleOfScreen = [
    'الصفحة الرئيسية',
    'الدردشات',
    'الاشعارات',
    'الملف الشخصي',
  ];
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

  Future<void> changeValueOfIndex(value) async {
    index = value;
    bottomSheet = false;
    if (index == 0) {
      getAllCategories();
    }
    if (index == 1) {
      getAllAccountPatients();
    }

    if (index == 3) {
      getDoctorsData();
      update();
    }
    print(index);
    update();
  }

  Future<void> getAllAccountPatients() async {
    if (patients.isNotEmpty) {
      patients = [];
      update();

      patients = [];
      FirebaseFirestore.instance.collection("patients").get().then((value) {
        value.docs.forEach((element) {
          patients.add(PatientsAccountModel.formJson(element.data()));

          update();

          print(patients.length);
          update();

          print(patients.length);
        });
        update();
      });
    } else {
      FirebaseFirestore.instance.collection("patients").get().then((value) {
        value.docs.forEach((element) {
          patients.add(PatientsAccountModel.formJson(element.data()));

          update();

          print(patients.length);
        });
        update();
      });
    }

    update();
  }

  Future<void> getDoctorsData() async {
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(tokenOfDoctors)
        .get()
        .then((value) {
      doctorAccountModel = DoctorAccountModel.formJson(value.data()!);
      print("The User is${doctorAccountModel?.name.toString()}");
      update();
    });
    update();
  }

  Future<void> getLastMessageWithPatients(token, value) async {
    chats = [];
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(tokenOfDoctors)
        .collection("patients")
        .doc("$token")
        .collection("messages")
        .where("value", isEqualTo: value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        chats.add(MessageModel.fromJson(element.data()));

        update();
        print(chats[0].text);
      });
    });

    update();
  }

  Future<void> changeValueOfBottomSheet(bool value) async {
    bottomSheet = value;
    update();
  }

  List<CategoriesModel> categories = [];

  void getAllCategories() {
    categories = [];
    FirebaseFirestore.instance.collection("Categories").get().then((value) {
      value.docs.forEach((element) {
        categories.add(CategoriesModel.fromJson(element.data()));
        update();
      });
    });
  }

  CategoriesModel? categoriesModel;
  Future<void> addCategories(
      nameCategories, detailsCategories, imageCategories) async {
    if (nameCategories != null &&
        detailsCategories != null &&
        imageCategorie?.path.length != 0) {
      categoriesModel = CategoriesModel(
          nameCategories, detailsCategories, imageCategories, false);
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        FirebaseFirestore.instance
            .collection("Categories")
            .where("nameCategories", isEqualTo: nameCategories)
            .get()
            .then((value) {
          if (value.docs.length == 0) {
            FirebaseFirestore.instance
                .collection("Categories")
                .add(categoriesModel?.toMap() ?? {})
                .then((values) {
              FirebaseFirestore.instance
                  .collection("Categories")
                  .doc(values.id)
                  .update({"id": values.id}).then((value) {
                FirebaseFirestore.instance
                    .collection("patients")
                    .get()
                    .then((value) {
                  if (value.docs.length != 0) {
                    value.docs.forEach((element) {
                      update();

                      print(value.docs.length);
                      print("!");
                      update();
                      categoriesModel = CategoriesModel(nameCategories,
                          detailsCategories, imageCategories, false,
                          id: values.id);
                      FirebaseFirestore.instance
                          .collection('patients')
                          .doc(element.data()['token'])
                          .collection("myCategories")
                          .add(categoriesModel?.toMap() ?? {})
                          .then((value) {
                        update();

                        FirebaseFirestore.instance
                            .collection('patients')
                            .doc(element.data()['token'])
                            .collection("myCategories")
                            .doc(value.id)
                            .update({"idOfMyCategories": value.id}).then(
                                (value) {
                          update();
                        });
                      });
                    });
                    changeValueOfBottomSheet(false).then((value) {
                      getAllCategories();
                      valueOfImage = '';
                      print("valueOfImage is${valueOfImage?.length}");
                      update();
                    });
                  }
                });
              });
              print(values.id);
              update();
            }).catchError((error) {});
          }
        });
        update();
      });
      update();
    }

    update();
  }

  var picker = ImagePicker();
  File? imageCategorie;

  Future<void> getImage() async {
    imageCategorie = null;
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageCategorie = File(pickedFile.path);
      print(imageCategorie!.path);
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
        .child('Categories/${Uri.file(imageCategorie!.path).pathSegments.last}')
        .putFile(imageCategorie!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        valueOfImage = value;
        imageCategorie = null;
        print("the value is $valueOfImage");
        update();
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future<void> deleteCategories(id) async {
    FirebaseFirestore.instance
        .collection("Categories")
        .doc('$id')
        .delete()
        .then((value) {
      getAllCategories();
      update();
    });
  }
}

List<MessageModel> chats = [];
