import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //TODO: Implement HomeController

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

  void increment() => count.value++;

  void moveBetweenPages(route, {arguments}) {
    Get.offNamed(route, arguments: arguments);
  }

  void login(dynamic email, dynamic password) {
    checkIsEmailInDoctorsCollection(email, password);

    update();
  }

  void checkIsEmailInDoctorsCollection(dynamic email, dynamic password) {
    FirebaseFirestore.instance
        .collection('doctors')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          GetStorage().write('token', value.user?.uid);

          tokenOfDoctors = value.user!.uid;
          update();
          moveBetweenPages('layout');
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
