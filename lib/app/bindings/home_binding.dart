import 'package:get/get.dart';
import 'package:questionnaire_app/presentation/controllers/auth_controller.dart';
import 'package:questionnaire_app/presentation/controllers/home_controller.dart';
import 'package:questionnaire_app/presentation/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
