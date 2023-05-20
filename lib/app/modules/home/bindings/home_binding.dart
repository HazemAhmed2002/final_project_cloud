import 'package:test_project/app/modules/home/controllers/add_article_controller.dart';
import 'package:test_project/app/modules/home/controllers/article_details_controller.dart';
import 'package:test_project/app/modules/home/controllers/selection_doctor_or_sick_controller.dart';
import 'package:test_project/app/modules/home/controllers/update_profile_controller.dart';
import 'package:get/get.dart';
import '../controllers/group_chat_controller.dart';
import '../controllers/layout_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/register_controller.dart';
import '../controllers/update_article_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateArticleController>(
      () => UpdateArticleController(),
    );
    Get.lazyPut<ArticleDetailsController>(
      () => ArticleDetailsController(),
    );
    Get.lazyPut<AddArticleController>(
      () => AddArticleController(),
    );
    Get.lazyPut<GroupChatController>(
      () => GroupChatController(),
    );
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(),
    );

    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<PageSelectionDoctorOrSickController>(
      () => PageSelectionDoctorOrSickController(),
    );
  }
}
