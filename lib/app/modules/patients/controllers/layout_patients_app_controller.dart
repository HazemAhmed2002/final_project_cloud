import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/categories_model.dart';
import 'package:test_project/app/data/doctor_account_model.dart';
import 'package:test_project/app/data/patients_account_model.dart';
import 'package:test_project/app/modules/patients/controllers/article_controller.dart';
import 'package:test_project/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:test_project/app/modules/patients/views/chat_patients_view.dart';
import 'package:test_project/app/modules/patients/views/home_patients_view.dart';
import 'package:test_project/app/modules/patients/views/profile_patients_view.dart';
import 'package:test_project/app/modules/patients/views/subscriptions_view.dart';
import 'package:get/get.dart';

import '../../home/controllers/register_controller.dart';

dynamic tokenOfPatients;
var indexPatients = 0;

class LayoutPatientsAppController extends GetxController {
  //TODO: Implement LayoutPatientsAppController
  List<CategoriesModel> categories = [];
  List<CategoriesModel> subsriptions = [];
  ArticleController articleController = ArticleController();
  GroupChatPatientsController groupChatPatientsController =
      GroupChatPatientsController();

  Future<void> getAllCategories() async {
    if (categories.isNotEmpty) {
      categories = [];
      update();

      FirebaseFirestore.instance
          .collection("patients")
          .doc(tokenOfPatients)
          .collection("myCategories")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          categories.add(CategoriesModel.fromJson(element.data()));
          update();
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection("patients")
          .doc(tokenOfPatients)
          .collection("myCategories")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          categories.add(CategoriesModel.fromJson(element.data()));
          update();
        });
      });
    }
    // update();
  }

  Future<void> updateCategories(id) async {
    print("my id is$id");
    FirebaseFirestore.instance
        .collection("patients")
        .doc(tokenOfPatients)
        .collection("myCategories")
        .doc(id)
        .get()
        .then((value) {
      if (value.data()?['like'] == true) {
        FirebaseFirestore.instance
            .collection("patients")
            .doc(tokenOfPatients)
            .collection("myCategories")
            .doc(id)
            .update({"like": false, "idOfPatients": tokenOfPatients}).then(
                (value) {
          getAllSubsriptions();
          getAllCategories();
        });
      }
      if (value.data()?['like'] == false) {
        FirebaseFirestore.instance
            .collection("patients")
            .doc(tokenOfPatients)
            .collection("myCategories")
            .doc(id)
            .update({"like": true, "idOfPatients": tokenOfPatients}).then(
                (value) {
          getAllSubsriptions();
          getAllCategories();
        });
      }
    });
    update();
  }

  Future<void> getAllSubsriptions() async {
    if (subsriptions.isNotEmpty) {
      subsriptions = [];
      update();
      FirebaseFirestore.instance
          .collection("patients")
          .doc(tokenOfPatients)
          .collection("myCategories")
          .where("like", isEqualTo: true)
          .where("idOfPatients", isEqualTo: tokenOfPatients)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          subsriptions.add(CategoriesModel.fromJson(element.data()));
          print("the subsriptions is${subsriptions.length}");
          update();
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection("patients")
          .doc(tokenOfPatients)
          .collection("myCategories")
          .where("like", isEqualTo: true)
          .where("idOfPatients", isEqualTo: tokenOfPatients)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          subsriptions.add(CategoriesModel.fromJson(element.data()));
          print("the subsriptions is${subsriptions.length}");
          update();
        });
      });
    }
  }

  final count = 0.obs;
  List screenPatients = [
    HomePatientsView(),
    ChatPatientsView(),
    SubscriptionsView(),
    ProfilePatientsView(),
  ];
  List titleOfPatientsScreen = [
    'الصفحة الرئيسية',
    'الدردشات',
    'الاشتراكات',
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
    indexPatients = value;
    if (indexPatients == 0) {
      getAllCategories();
    }
    if (indexPatients == 1) {
      await getAllAccountDoctors();
      update();
    }
    if (indexPatients == 2) {
      await getAllSubsriptions();
      update();
    }
    if (indexPatients == 3) {
      await getPatientsData();
      update();
    }
    print(indexPatients);
    update();
  }

  List<DoctorAccountModel> doctors = [];
  Future<void> getAllAccountDoctors() async {
    doctors = [];
    FirebaseFirestore.instance.collection("doctors").get().then((value) {
      value.docs.forEach((element) {
        doctors.add(DoctorAccountModel.formJson(element.data()));
        update();

        print(doctors.length);
      });
    });
    update();
  }

  Future<void> getPatientsData() async {
    FirebaseFirestore.instance
        .collection("patients")
        .doc(tokenOfPatients)
        .get()
        .then((value) {
      patientsAccountModel = PatientsAccountModel.formJson(value.data()!);
      print("The User is${patientsAccountModel?.name.toString()}");
      update();
    });
    update();
  }
}
