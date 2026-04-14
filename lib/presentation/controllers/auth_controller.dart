import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/data/services/api_service.dart';
import 'package:questionnaire_app/data/services/local_storage_service.dart';

class AuthController extends GetxController {
  final ApiService api = Get.find<ApiService>();
  final LocalStorageService storage = Get.find<LocalStorageService>();

  final RxBool isLoading = false.obs;

  void _showToast({
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast length = Toast.LENGTH_LONG,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
      _showToast(
        message: "All fields are required",
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    final trimmedEmail = email.trim();
    if (!GetUtils.isEmail(trimmedEmail)) {
      _showToast(
        message: "Please enter a valid email address",
        backgroundColor: Colors.orange,
      );
      return;
    }

    if (password != confirmPassword) {
      _showToast(
        message: "Passwords do not match",
        backgroundColor: Colors.orange,
      );
      return;
    }

    if (password.length < 6) {
      _showToast(
        message: "Password must be at least 6 characters",
        backgroundColor: Colors.orange,
      );
      return;
    }

    try {
      isLoading.value = true;
      final success = await api.register(trimmedEmail, password);

      if (success) {
        _showToast(
          message: "Account created! Please log in.",
          backgroundColor: Colors.green,
        );
        Get.offNamed(AppRoutes.login);
      } else {
        _showToast(
          message: "Registration failed. Email may already exist.",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      _showToast(
        message: "Something went wrong: ${e.toString().split('\n').first}",
        backgroundColor: Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      _showToast(
        message: "Please enter email and password",
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    if (!GetUtils.isEmail(trimmedEmail)) {
      _showToast(
        message: "Invalid email format",
        backgroundColor: Colors.orange,
      );
      return;
    }

    try {
      isLoading.value = true;
      final userData = await api.login(trimmedEmail, trimmedPassword);

      if (userData != null) {
        await storage.saveUser(trimmedEmail);
        Get.offNamed(AppRoutes.home);
        _showToast(
          message: "Logged in successfully",
          backgroundColor: Colors.green,
        );
      } else {
        _showToast(
          message: "Invalid email or password",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e, stackTrace) {
      log("Login error: $e\n$stackTrace");
      _showToast(
        message: "Failed to connect. Check your internet connection.",
        backgroundColor: Colors.redAccent,
        length: Toast.LENGTH_LONG,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await storage.clearUser();
      Get.offAllNamed(AppRoutes.login);
      _showToast(
        message: "Logged out successfully",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      _showToast(message: "Logout failed", backgroundColor: Colors.redAccent);
    }
  }

  bool get isLoggedIn => storage.getCurrentUser() != null;
  String? get currentUserEmail => storage.getCurrentUser()?.email;
}
