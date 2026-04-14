import 'package:get/get.dart';
import 'package:questionnaire_app/presentation/controllers/auth_controller.dart';
import 'package:questionnaire_app/presentation/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.put<AuthController>(AuthController());
  }
}
