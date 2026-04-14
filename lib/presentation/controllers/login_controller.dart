import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void handleLogin() {
    _authController.login(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void goToRegister() => Get.toNamed(AppRoutes.register);

  bool get isLoading => _authController.isLoading.value;
}
