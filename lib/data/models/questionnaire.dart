import 'package:hive/hive.dart';
import 'question.dart';

part 'questionnaire.g.dart';

@HiveType(typeId: 2)
class Questionnaire {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<Question> questions;

  Questionnaire({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}