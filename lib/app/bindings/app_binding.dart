import 'package:get/get.dart';
import 'package:questionnaire_app/data/services/api_service.dart';
import 'package:questionnaire_app/data/services/local_storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<LocalStorageService>(() => LocalStorageService(), fenix: true);
  }
}
