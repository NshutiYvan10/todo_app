// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 1;

  @override
  TaskCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskCategory.work;
      case 1:
        return TaskCategory.personal;
      case 2:
        return TaskCategory.health;
      case 3:
        return TaskCategory.education;
      case 4:
        return TaskCategory.shopping;
      case 5:
        return TaskCategory.other;
      default:
        return TaskCategory.other;
    }
  }

  @override
  void write(BinaryWriter writer, TaskCategory obj) {
    switch (obj) {
      case TaskCategory.work:
        writer.writeByte(0);
        break;
      case TaskCategory.personal:
        writer.writeByte(1);
        break;
      case TaskCategory.health:
        writer.writeByte(2);
        break;
      case TaskCategory.education:
        writer.writeByte(3);
        break;
      case TaskCategory.shopping:
        writer.writeByte(4);
        break;
      case TaskCategory.other:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskCategoryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
