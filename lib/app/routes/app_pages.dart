import 'package:get/get.dart';
import 'package:questionnaire_app/presentation/screens/home_screen.dart';
import 'package:questionnaire_app/presentation/screens/login_screen.dart';
import 'package:questionnaire_app/presentation/screens/profile_screen.dart';
import 'package:questionnaire_app/presentation/screens/questionnaire_screen.dart';
import 'package:questionnaire_app/presentation/screens/register_screen.dart';
import '../../presentation/screens/splash_screen.dart';
import '../bindings/app_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/questionnaire_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: AppBinding(), // good place for global init
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.questionnaire,
      page: () => QuestionnaireScreen(),
      binding: QuestionnaireBinding(),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
