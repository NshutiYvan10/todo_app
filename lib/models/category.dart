import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
enum TaskCategory {
  @HiveField(0)
  work,
  @HiveField(1)
  personal,
  @HiveField(2)
  health,
  @HiveField(3)
  education,
  @HiveField(4)
  shopping,
  @HiveField(5)
  other,
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.work:
        return 'Work';
      case TaskCategory.personal:
        return 'Personal';
      case TaskCategory.health:
        return 'Health';
      case TaskCategory.education:
        return 'Education';
      case TaskCategory.shopping:
        return 'Shopping';
      case TaskCategory.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.work:
        return Icons.work;
      case TaskCategory.personal:
        return Icons.person;
      case TaskCategory.health:
        return Icons.health_and_safety;
      case TaskCategory.education:
        return Icons.school;
      case TaskCategory.shopping:
        return Icons.shopping_cart;
      case TaskCategory.other:
        return Icons.category;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.work:
        return Colors.blue;
      case TaskCategory.personal:
        return Colors.green;
      case TaskCategory.health:
        return Colors.red;
      case TaskCategory.education:
        return Colors.purple;
      case TaskCategory.shopping:
        return Colors.orange;
      case TaskCategory.other:
        return Colors.grey;
    }
  }
}
