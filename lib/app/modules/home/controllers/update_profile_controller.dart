import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/doctor_account_model.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateProfileController extends GetxController {
  //TODO: Implement UpdateProfileController

  final count = 0.obs;
  LoginController loginController = LoginController();
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

  void updateDoctorsData({
    required String name,
    required String phone,
    required String bio,
    String? image,
  }) {
    doctorAccountModel = DoctorAccountModel(
      name,
      doctorAccountModel!.email,
      phone,
      doctorAccountModel?.token,
      bio,
      image ?? doctorAccountModel!.image,
    );
    LayoutController layoutController = LayoutController();
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorAccountModel!.token)
        .update(doctorAccountModel?.toMAp() ?? {})
        .then((value) {
      index == 2;
      update();
      layoutController.getDoctorsData().then((value) {
        loginController.moveBetweenPages('layout');
        update();
      });
    }).catchError((error) {});
    update();
  }

  File? profileImage;
  String? valueOfImage;
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        valueOfImage = value;
        print("the value of image is$valueOfImage");

        update();
      }).catchError((error) {});
    }).catchError((error) {});
  }

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      print(pickedFile.path);

      update();
    } else {
      print('No image selected.');
    }
  }
}
