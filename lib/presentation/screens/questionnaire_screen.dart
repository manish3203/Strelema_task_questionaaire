import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/data/models/questionnaire.dart';
import 'package:questionnaire_app/presentation/controllers/questionnaire_controller.dart';

class QuestionnaireScreen extends StatelessWidget {
  QuestionnaireScreen({super.key});

  final QuestionnaireController controller =
      Get.find<QuestionnaireController>();

  @override
  Widget build(BuildContext context) {
    final Questionnaire questionnaire = Get.arguments as Questionnaire;
    controller.loadPreviousAnswers(questionnaire.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          questionnaire.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              itemCount: questionnaire.questions.length,
              itemBuilder: (context, index) {
                final question = questionnaire.questions[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// QUESTION TEXT
                      Text(
                        "Question ${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        question.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// OPTIONS
                      ...question.options.map((option) {
                        return Obx(() {
                          final selected =
                              controller.selectedAnswers[question.id] == option;

                          return GestureDetector(
                            onTap: controller.isAlreadySubmitted.value
                                ? null
                                : () {
                                    controller.selectedAnswers[question.id] =
                                        option;
                                  },

                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: controller.isAlreadySubmitted.value
                                    ? Colors.grey.shade200
                                    : selected
                                    ? const Color(
                                        0xFF5F60F5,
                                      ).withValues(alpha: 0.08)
                                    : const Color(0xFFF5F6FA),

                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: controller.isAlreadySubmitted.value
                                      ? Colors.grey
                                      : selected
                                      ? const Color(0xFF5F60F5)
                                      : Colors.grey,

                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    selected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    size: 18,
                                    color: selected
                                        ? const Color(0xFF5F60F5)
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: const TextStyle(fontSize: 14.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      }),
                    ],
                  ),
                );
              },
            ),
          ),

          Obx(() {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed:
                        controller.isAlreadySubmitted.value ||
                            controller.isSubmitting.value
                        ? null
                        : () => controller.submit(questionnaire),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: controller.isAlreadySubmitted.value
                            ? null
                            : const LinearGradient(
                                colors: [Color(0xFF5F60F5), Color(0xFF7C7DFF)],
                              ),
                        color: controller.isAlreadySubmitted.value
                            ? Colors.grey.shade400
                            : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                controller.isAlreadySubmitted.value
                                    ? 'Already Submitted'
                                    : 'Submit Answers',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
