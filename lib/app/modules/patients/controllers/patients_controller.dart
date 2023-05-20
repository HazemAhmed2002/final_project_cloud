import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PatientsController extends GetxController {
  //TODO: Implement PatientsController
  LoginController loginController = LoginController();
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

  void login(dynamic email, dynamic password) {
    checkIsEmailInDoctorsCollection(email, password);
    update();
  }

  void checkIsEmailInDoctorsCollection(dynamic email, dynamic password) {
    FirebaseFirestore.instance
        .collection('patients')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          GetStorage().write("tokenOfPatients", value.user?.uid);

          tokenOfPatients = value.user!.uid;
          update();
          loginController.moveBetweenPages('LayoutPatientsAppView');
        }).catchError((error) {
          print(error.toString());
        });
      } else {
        print("The email isn't in doctors ");
      }
    });
    update();
  }
}
