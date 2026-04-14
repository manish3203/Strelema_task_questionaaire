import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)
class Question {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final List<String> options;

  Question({required this.id, required this.text, required this.options});
}