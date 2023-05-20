import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

bool? valueOfSelection;

class PageSelectionDoctorOrSickController extends GetxController {
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

  void changeValue(value) {
    valueOfSelection = value;
    print(valueOfSelection);
    if (valueOfSelection == false) {
      GetStorage().write("valueOfSelection", false);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        loginController.moveBetweenPages('login');
      });
    } else {
      GetStorage().write("valueOfSelection", true);

      Future.delayed(Duration(milliseconds: 500)).then((value) {
        loginController.moveBetweenPages('patients');
      });
    }
    update();
  }
}
