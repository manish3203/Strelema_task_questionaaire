import 'package:hive/hive.dart';

part 'submission.g.dart';
@HiveType(typeId: 3)
class Submission extends HiveObject {
  @HiveField(0)
  String userEmail; // ← ADD THIS

  @HiveField(1)
  String questionnaireId;

  @HiveField(2)
  String questionnaireName;

  @HiveField(3)
  Map<String, String> answers;

  @HiveField(4)
  DateTime submittedAt;

  @HiveField(5)
  double? latitude;

  @HiveField(6)
  double? longitude;

  Submission({
    required this.userEmail,
    required this.questionnaireId,
    required this.questionnaireName,
    required this.answers,
    required this.submittedAt,
    this.latitude,
    this.longitude,
  });
}
