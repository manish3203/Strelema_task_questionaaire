import 'package:get/get.dart';

import '../../data/models/submission.dart';
import '../../data/services/local_storage_service.dart';
class ProfileController extends GetxController {
  final LocalStorageService storage = Get.find();

  final RxString email = ''.obs;
  final RxList<Submission> history = <Submission>[].obs;

  int get totalFilled => history.length;

  @override
  void onInit() {
    super.onInit();
    refreshProfile();
  }

  void refreshProfile() {
  final currentUser = storage.getCurrentUser();

  email.value = currentUser?.email ?? 'No user';

  if (currentUser == null) {
    history.clear();
    return;
  }

  final userEmail = currentUser.email;

  final allSubmissions = storage.getSubmissions();

  history.assignAll(
    allSubmissions.where((s) => s.userEmail == userEmail).toList(), // ✅ FIX
  );
}

}
