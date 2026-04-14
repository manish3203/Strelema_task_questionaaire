import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:questionnaire_app/data/models/submission.dart';
import 'package:questionnaire_app/data/models/user.dart';

class LocalStorageService extends GetxService {
  // Access already-opened boxes (opened in main.dart)
  Box<Submission> get submissionBox => Hive.box<Submission>('submissions');
  Box get userBox => Hive.box('user');

  Future<void> saveUser(String email) async {
    final user = User(email: email);
    await userBox.put('current_user', user);
  }

  User? getCurrentUser() {
    return userBox.get('current_user') as User?;
  }

  Future<void> clearUser() async {
    await userBox.delete('current_user');
  }

  Future<void> saveSubmission(Submission submission) async {
    await submissionBox.add(submission);
  }

  List<Submission> getSubmissions() {
    return submissionBox.values.toList();
  }

  int getSubmissionCount() {
    return submissionBox.length;
  }
}