import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:questionnaire_app/app/bindings/app_binding.dart';
import 'package:questionnaire_app/app/routes/app_pages.dart';
import 'package:questionnaire_app/data/models/submission.dart';
import 'app/routes/app_routes.dart';
import 'data/models/question.dart';
import 'data/models/questionnaire.dart';
import 'data/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(QuestionnaireAdapter());
  Hive.registerAdapter(SubmissionAdapter());

  // Open boxes globally - they stay open forever
  await Hive.openBox<Submission>('submissions');
  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire App',
      initialBinding: AppBinding(),
      getPages: AppPages.routes,

      initialRoute: AppRoutes.splash, // or check if logged in
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
