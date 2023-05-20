import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/patients_account_model.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'layout_patients_app_controller.dart';

class RegisterPatientsController extends GetxController {
  //TODO: Implement RegisterPatientsController

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

  void register(dynamic email, dynamic password, dynamic name, dynamic phone) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      GetStorage().write("tokenOfPatients", value.user?.uid);
      createAccount(name, email, phone, value.user?.uid, password);
      update();
    }).catchError((error) {
      print(error.toString());
    });
    update();
  }

  Future<void> createAccount(name, email, phone, uid, password) async {
    patientsAccountModel = PatientsAccountModel(
        name,
        email,
        phone,
        uid,
        "write your bio",
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
    FirebaseFirestore.instance
        .collection('patients')
        .doc(uid)
        .set(patientsAccountModel?.toMAp() ?? {})
        .then((value) {
      LoginController loginController = Get.put(LoginController());

      tokenOfPatients = patientsAccountModel?.token;
      print(tokenOfPatients);
      update();
      print("the token is$tokenOfPatients");
      getAllCategoriesOfPatients().then((value) {
        loginController.moveBetweenPages('LayoutPatientsAppView');
        update();
        print(patientsAccountModel?.name);
      });
    }).catchError((error) {
      print(error.toString());
    });
    update();
  }

  Future<void> getAllCategoriesOfPatients() async {
    FirebaseFirestore.instance
        .collection("patients")
        .doc(tokenOfPatients)
        .collection("myCategories")
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        FirebaseFirestore.instance.collection("Categories").get().then((value) {
          if (value.docs.isNotEmpty) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("patients")
                  .doc(tokenOfPatients)
                  .collection("myCategories")
                  .add(element.data())
                  .then((value) {
                update();

                FirebaseFirestore.instance
                    .collection('patients')
                    .doc(tokenOfPatients)
                    .collection("myCategories")
                    .doc(value.id)
                    .update({"idOfMyCategories": value.id}).then((value) {
                  update();
                });
              });
            });
          }
          update();
        });
      }
    });
    update();
  }
}
