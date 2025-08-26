import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/priority.dart';
import '../models/category.dart';
import 'auth_provider.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final authState = ref.watch(authProvider);
  return TaskNotifier(authState);
});

final taskStatsProvider = Provider<TaskStats>((ref) {
  final tasks = ref.watch(taskProvider);
  final authState = ref.watch(authProvider);

  if (authState is! Authenticated) {
    return TaskStats(
      totalTasks: 0,
      completedTasks: 0,
      pendingTasks: 0,
      overdueTasks: 0,
      todayTasks: 0,
      completionRate: 0.0,
    );
  }

  final userTasks = tasks.where((task) => task.userId == authState.user.id).toList();
  final completedTasks = userTasks.where((task) => task.isCompleted).length;
  final pendingTasks = userTasks.where((task) => !task.isCompleted).length;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final overdueTasks = userTasks.where((task) {
    if (task.isCompleted || task.dueDate == null) return false;
    return task.dueDate!.isBefore(today);
  }).length;

  final todayTasks = userTasks.where((task) {
    if (task.dueDate == null) return false;
    final dueDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
    return dueDate.isAtSameMomentAs(today);
  }).length;

  final completionRate = userTasks.isNotEmpty ? completedTasks / userTasks.length : 0.0;

  return TaskStats(
    totalTasks: userTasks.length,
    completedTasks: completedTasks,
    pendingTasks: pendingTasks,
    overdueTasks: overdueTasks,
    todayTasks: todayTasks,
    completionRate: completionRate,
  );
});

class TaskNotifier extends StateNotifier<List<Task>> {
  late final Box<Task> _taskBox;
  final AuthState _authState;

  TaskNotifier(this._authState) : super([]) {
    _init();
  }

  void _init() async {
    try {
      _taskBox = await Hive.openBox<Task>('tasks');
      _loadTasks();
    } catch (e) {
      print('Error initializing task box: $e');
    }
  }

  void _loadTasks() {
    if (_authState is Authenticated) {
      final userId = (_authState as Authenticated).user.id;
      final userTasks = _taskBox.values.where((task) => task.userId == userId).toList();
      state = userTasks;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _taskBox.put(task.id, task);
      state = [...state, task];
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _taskBox.put(updatedTask.id, updatedTask);
      state = state.map((task) => task.id == updatedTask.id ? updatedTask : task).toList();
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _taskBox.delete(taskId);
      state = state.where((task) => task.id != taskId).toList();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<void> toggleTask(String taskId) async {
    try {
      final taskIndex = state.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        final task = state[taskIndex];
        final updatedTask = task.copyWith(
          isCompleted: !task.isCompleted,
          completedAt: !task.isCompleted ? DateTime.now() : null,
        );
        await _taskBox.put(updatedTask.id, updatedTask);
        state = state.map((t) => t.id == taskId ? updatedTask : t).toList();
      }
    } catch (e) {
      print('Error toggling task: $e');
    }
  }

  List<Task> getTasksForDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    return state.where((task) {
      if (task.dueDate == null) return false;
      final taskDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
      return taskDate.isAtSameMomentAs(targetDate);
    }).toList();
  }

  List<Task> getTasksByCategory(TaskCategory category) {
    return state.where((task) => task.category == category).toList();
  }

  List<Task> getTasksByPriority(TaskPriority priority) {
    return state.where((task) => task.priority == priority).toList();
  }

  List<Task> getOverdueTasks() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return state.where((task) {
      if (task.isCompleted || task.dueDate == null) return false;
      return task.dueDate!.isBefore(today);
    }).toList();
  }

  List<Task> getTodayTasks() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return state.where((task) {
      if (task.dueDate == null) return false;
      final dueDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
      return dueDate.isAtSameMomentAs(today);
    }).toList();
  }

  void refreshTasks() {
    _loadTasks();
  }
}

class TaskStats {
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final int overdueTasks;
  final int todayTasks;
  final double completionRate;

  TaskStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.overdueTasks,
    required this.todayTasks,
    required this.completionRate,
  });
}
