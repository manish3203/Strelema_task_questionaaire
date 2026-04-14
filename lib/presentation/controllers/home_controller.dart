import 'package:get/get.dart';
import 'package:questionnaire_app/data/models/questionnaire.dart';
import 'package:questionnaire_app/data/services/api_service.dart';

class HomeController extends GetxController {
  final ApiService api = Get.find();
  var questionnaires = <Questionnaire>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestionnaires();
  }

  Future<void> fetchQuestionnaires() async {
    isLoading.value = true;
    questionnaires.value = await api.getQuestionnaires();
    isLoading.value = false;
  }
}