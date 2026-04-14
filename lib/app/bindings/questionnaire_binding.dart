import 'package:get/get.dart';

import '../../presentation/controllers/questionnaire_controller.dart';

class QuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionnaireController>(() => QuestionnaireController());
  }
}
