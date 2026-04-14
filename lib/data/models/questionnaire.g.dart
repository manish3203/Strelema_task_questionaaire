// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionnaireAdapter extends TypeAdapter<Questionnaire> {
  @override
  final int typeId = 2;

  @override
  Questionnaire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Questionnaire(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      questions: (fields[3] as List).cast<Question>(),
    );
  }

  @override
  void write(BinaryWriter writer, Questionnaire obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionnaireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
