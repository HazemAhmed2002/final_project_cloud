import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/patients_account_model.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateProfilePatientsController extends GetxController {
  //TODO: Implement UpdateProfileController

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

  LoginController loginController = LoginController();
  void updatePatientsData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    patientsAccountModel = PatientsAccountModel(
      name,
      patientsAccountModel!.email,
      phone,
      patientsAccountModel?.token,
      bio,
      image ?? patientsAccountModel!.image,
      cover ?? patientsAccountModel!.cover,
    );
    LayoutPatientsAppController layoutController =
        LayoutPatientsAppController();
    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientsAccountModel!.token)
        .update(patientsAccountModel?.toMAp() ?? {})
        .then((value) {
      final layoutPatientsAppController =
          Get.lazyPut(() => LayoutPatientsAppController());
      loginController.moveBetweenPages('LayoutPatientsAppView');

      layoutController.getPatientsData();
      update();
    }).catchError((error) {});
    update();
  }

  File? profileImage;
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('patients/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updatePatientsData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        update();
      }).catchError((error) {});
    }).catchError((error) {});
  }

  var picker = ImagePicker();

  Future<void> getProfileImage(name, phone, bio) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage(name: name, phone: phone, bio: bio);
      print(pickedFile.path);

      update();
    } else {
      print('No image selected.');
    }
  }
}
