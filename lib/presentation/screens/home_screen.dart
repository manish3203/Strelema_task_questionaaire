import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/app/routes/app_routes.dart';
import 'package:questionnaire_app/presentation/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Questionnaires',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.profile),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5FA),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 18,
                  color: Color(0xFF555555),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.questionnaires.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 52,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 12),
                Text(
                  'No questionnaires available',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          itemCount: controller.questionnaires.length,
          itemBuilder: (context, index) {
            final q = controller.questionnaires[index];
            return _QuestionnaireCard(questionnaire: q);
          },
        );
      }),
    );
  }
}

class _QuestionnaireCard extends StatelessWidget {
  final dynamic questionnaire;
  const _QuestionnaireCard({required this.questionnaire});

  @override
  Widget build(BuildContext context) {
    final color = _accentColor(questionnaire.title);

    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.questionnaire, arguments: questionnaire),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored icon tile
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                _iconFor(questionnaire.title),
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Title + description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questionnaire.title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    questionnaire.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF9094A4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Arrow
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5FA),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(Icons.chevron_right_rounded, color: color, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Color _accentColor(String title) {
    const colors = [
      Color(0xFF6C63FF),
      Color(0xFF43A047),
      Color(0xFFFB8C00),
      Color(0xFFE91E63),
      Color(0xFF0288D1),
    ];
    return colors[title.hashCode.abs() % colors.length];
  }

  IconData _iconFor(String title) {
    final t = title.toLowerCase();
    if (t.contains('wellness') || t.contains('mental'))
      return Icons.self_improvement_rounded;
    if (t.contains('fitness') || t.contains('exercise'))
      return Icons.fitness_center_rounded;
    if (t.contains('sleep')) return Icons.bedtime_rounded;
    if (t.contains('nutrition') || t.contains('diet'))
      return Icons.restaurant_rounded;
    return Icons.assignment_rounded;
  }
}
