import 'package:hive/hive.dart';
import 'priority.dart';
import 'category.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? dueDate;

  @HiveField(6)
  final TaskPriority priority;

  @HiveField(7)
  final TaskCategory category;

  @HiveField(8)
  final String userId;

  @HiveField(9)
  final DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.category = TaskCategory.other,
    required this.userId,
    this.completedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
    TaskCategory? category,
    String? userId,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return dueDate!.isBefore(DateTime.now());
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, isCompleted: $isCompleted, priority: $priority, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.createdAt == createdAt &&
        other.dueDate == dueDate &&
        other.priority == priority &&
        other.category == category &&
        other.userId == userId &&
        other.completedAt == completedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode ^
    description.hashCode ^
    isCompleted.hashCode ^
    createdAt.hashCode ^
    dueDate.hashCode ^
    priority.hashCode ^
    category.hashCode ^
    userId.hashCode ^
    completedAt.hashCode;
  }
}
