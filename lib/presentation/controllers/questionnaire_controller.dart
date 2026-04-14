import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, Color;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/data/models/questionnaire.dart';
import 'package:questionnaire_app/data/models/submission.dart';
import 'package:questionnaire_app/data/services/local_storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'profile_controller.dart';

class QuestionnaireController extends GetxController {
  final LocalStorageService storage = Get.find();
  final ProfileController profileController = Get.find();

  var selectedAnswers = <String, String>{}.obs;
  var location = Rxn<Position>();

  final isSubmitting = false.obs;
  final isAlreadySubmitted = false.obs;

  // ================= TOAST =================
  void _showToast({
    required String message,
    Color bgColor = Colors.black87,
    Color textColor = Colors.white,
    Toast length = Toast.LENGTH_LONG,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 3,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  // ================= LOCATION =================
  Future<bool> getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showToast(
          message: "Please enable location services",
          bgColor: Colors.orange,
        );
        await Geolocator.openLocationSettings();
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showToast(
          message: "Location permission denied",
          bgColor: Colors.redAccent,
        );
        return false;
      }

      if (permission == LocationPermission.deniedForever) {
        _showToast(
          message: "Enable permission from settings",
          bgColor: Colors.redAccent,
        );
        await Geolocator.openAppSettings();
        return false;
      }

      // ✅ STEP 1: Try last known
      Position? lastPosition = await Geolocator.getLastKnownPosition();

      if (lastPosition != null) {
        location.value = lastPosition;
      }

      // ✅ STEP 2: Try fresh location
      try {
        final LocationSettings locationSettings =
            defaultTargetPlatform == TargetPlatform.android
            ? AndroidSettings(
                accuracy: LocationAccuracy.medium,
                timeLimit: const Duration(seconds: 10),
              )
            : LocationSettings(
                accuracy: LocationAccuracy.medium,
                timeLimit: const Duration(seconds: 10),
              );

        location.value = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );

        return true;
      } on TimeoutException {
        // ⚠️ If timeout but we already have last location → allow
        if (location.value != null) {
          return true; // 🔥 IMPORTANT FIX
        }

        _showToast(message: "Location timeout", bgColor: Colors.redAccent);
        return false;
      }
    } catch (e) {
      // ⚠️ If error but location exists → allow
      if (location.value != null) {
        return true; // 🔥 IMPORTANT FIX
      }

      _showToast(message: "Failed to get location", bgColor: Colors.redAccent);
      return false;
    }
  }

  // ================= VALIDATION =================
  bool allAnswered(Questionnaire q) {
    return selectedAnswers.length == q.questions.length;
  }

  // ================= LOAD PREVIOUS =================
  void loadPreviousAnswers(String questionnaireId) {
    final email = profileController.email.value;
    final submissions = storage.getSubmissions();

    final existing = submissions.firstWhereOrNull(
      (sub) => sub.questionnaireId == questionnaireId && sub.userEmail == email,
    );

    if (existing != null) {
      selectedAnswers.assignAll(existing.answers);
      isAlreadySubmitted.value = true;
    } else {
      selectedAnswers.clear();
      isAlreadySubmitted.value = false;
    }
  }

  // ================= SUBMIT =================
  Future<void> submit(Questionnaire q) async {
    if (isSubmitting.value || isAlreadySubmitted.value) return;

    if (!allAnswered(q)) {
      _showToast(
        message: "Please answer all questions",
        bgColor: Colors.orange,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      // 🔥 Get location first
      final hasLocation = await getLocation();

      if (!hasLocation) {
        isSubmitting.value = false;
        return;
      }

      final submission = Submission(
        userEmail: profileController.email.value,
        questionnaireId: q.id,
        questionnaireName: q.title,
        answers: Map.from(selectedAnswers),
        submittedAt: DateTime.now(),
        latitude: location.value?.latitude,
        longitude: location.value?.longitude,
      );

      await storage.saveSubmission(submission);

      isAlreadySubmitted.value = true;
      selectedAnswers.clear();

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().refreshProfile();
      }

      Get.back();

      _showToast(message: "Submitted & saved offline", bgColor: Colors.green);
    } catch (e) {
      _showToast(message: "Failed to submit", bgColor: Colors.redAccent);
    } finally {
      isSubmitting.value = false;
    }
  }
}
