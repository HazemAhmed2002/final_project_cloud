import 'package:test_project/app/modules/patients/controllers/article_controller.dart';
import 'package:test_project/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/app/modules/patients/controllers/register_patients_controller.dart';
import 'package:test_project/app/modules/patients/controllers/update_profile_patients_controller.dart';
import 'package:test_project/app/modules/patients/views/article_details_patients_view.dart';
import 'package:get/get.dart';

import '../controllers/patients_controller.dart';

class PatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleController>(
      () => ArticleController(),
    );
    Get.lazyPut<GroupChatPatientsController>(
      () => GroupChatPatientsController(),
    );

    Get.lazyPut<UpdateProfilePatientsController>(
      () => UpdateProfilePatientsController(),
    );
    Get.lazyPut<LayoutPatientsAppController>(
      () => LayoutPatientsAppController(),
    );

    Get.lazyPut<RegisterPatientsController>(
      () => RegisterPatientsController(),
    );
    Get.lazyPut<PatientsController>(
      () => PatientsController(),
    );
    Get
      ..lazyPut<ArticleDetailsPatientsView>(
        () => ArticleDetailsPatientsView(),
      );
  }
}
