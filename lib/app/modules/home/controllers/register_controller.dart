import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/doctor_account_model.dart';
import 'package:test_project/app/data/patients_account_model.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login_controller.dart';

PatientsAccountModel? patientsAccountModel;
dynamic tokenOfDoctors;

class RegisterController extends GetxController {
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
      GetStorage().write('token', value.user?.uid);
      print(tokenOfDoctors);
      update();
      createAccount(name, email, phone, value.user?.uid, password);
    }).catchError((error) {
      print(error.toString());
    });
    update();
  }

  void createAccount(name, email, phone, uid, password) {
    doctorAccountModel = DoctorAccountModel(
        name,
        email,
        phone,
        uid,
        "اكتب سيرتك الذاتية",
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .set(doctorAccountModel?.toMAp() ?? {})
        .then((value) {
      tokenOfDoctors = doctorAccountModel?.token;
      update();
      LoginController loginController = Get.put(LoginController());
      loginController.moveBetweenPages('layout');
    }).catchError((error) {
      print(error.toString());
    });
    update();
  }
}
