import 'package:test_project/app/modules/home/views/add_article_view.dart';
import 'package:test_project/app/modules/home/views/update_article_view.dart';
import 'package:test_project/app/modules/patients/views/article_view.dart';
import 'package:test_project/app/modules/patients/views/group_chat_patients_view.dart';
import 'package:test_project/app/modules/patients/views/layout_patients_app/layout_patients_app_view.dart';
import 'package:test_project/app/modules/patients/views/update_profile_patients_view.dart';
import 'package:test_project/main.dart';
import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/controllers/selection_doctor_or_sick_controller.dart';
import '../modules/home/views/article_details_view.dart';
import '../modules/home/views/group_chat_view.dart';
import '../modules/home/views/layout/layout_view.dart';
import '../modules/home/views/login_view.dart';
import '../modules/home/views/register_view.dart';
import '../modules/home/views/selection_doctor_or_sick_view.dart';
import '../modules/home/views/update_profile_view.dart';
import '../modules/patients/bindings/patients_binding.dart';
import '../modules/patients/views/article_details_patients_view.dart';
import '../modules/patients/views/patients_view.dart';
import '../modules/patients/views/register_patients_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL = valueOfSelection == false
      ? tokenValueDoctor == true
          ? Routes.LAYOUT
          : Routes.PageSelectionDoctorOrPatient
      : tokenValuePatients == true
          ? Routes.LayoutPatientsAppView
          : Routes.PageSelectionDoctorOrPatient;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => LayoutView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SelectionDoctorOrSickView,
      page: () => SelectionDoctorOrSickView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.UpdateProfileView,
      page: () => UpdateProfileView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GroupChatView,
      page: () => GroupChatView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PATIENTS,
      page: () => PatientsView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: _Paths.Register_PATIENTS,
      page: () => RegisterPatientsView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: _Paths.LayoutPatientsAppView,
      page: () => LayoutPatientsAppView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: _Paths.UpdateProfilePatientsView,
      page: () => UpdateProfilePatientsView(),
      binding: PatientsBinding(),
    ),
    GetPage(
        name: _Paths.GroupChatPatientsView,
        page: () => GroupChatPatientsView(),
        binding: PatientsBinding()),
    GetPage(
        name: _Paths.AddArticleView,
        page: () => AddArticleView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.ArticleDetailsView,
        page: () => ArticleDetailsView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.ArticleView,
        page: () => ArticleView(),
        binding: PatientsBinding()),
    GetPage(
        name: _Paths.ArticleDetailsPatientsView,
        page: () => ArticleDetailsPatientsView(),
        binding: PatientsBinding()),
    GetPage(
        name: _Paths.UpdateArticleView,
        page: () => UpdateArticleView(),
        binding: HomeBinding()),
  ];
}
