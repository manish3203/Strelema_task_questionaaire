// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubmissionAdapter extends TypeAdapter<Submission> {
  @override
  final int typeId = 3;

  @override
  Submission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Submission(
      userEmail: fields[0] as String,
      questionnaireId: fields[1] as String,
      questionnaireName: fields[2] as String,
      answers: (fields[3] as Map).cast<String, String>(),
      submittedAt: fields[4] as DateTime,
      latitude: fields[5] as double?,
      longitude: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Submission obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userEmail)
      ..writeByte(1)
      ..write(obj.questionnaireId)
      ..writeByte(2)
      ..write(obj.questionnaireName)
      ..writeByte(3)
      ..write(obj.answers)
      ..writeByte(4)
      ..write(obj.submittedAt)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
