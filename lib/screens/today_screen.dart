import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/quotes_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/add_task_modal.dart';
import '../widgets/motivational_quote_card.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final authState = ref.watch(authProvider);
    final quote = ref.watch(dailyQuoteProvider);
    final theme = Theme.of(context);

    // Filter today's tasks
    final todayTasks = tasks.where((task) {
      if (task.dueDate == null) return false;
      final now = DateTime.now();
      final dueDate = task.dueDate!;
      return dueDate.year == now.year &&
          dueDate.month == now.month &&
          dueDate.day == now.day;
    }).toList();

    final completedTasks = todayTasks.where((task) => task.isCompleted).length;
    final totalTasks = todayTasks.length;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 120, // Space for floating navigation
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Today',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getFormattedDate(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),

              const SizedBox(height: 32),

              // Progress Indicator
              ProgressIndicatorWidget(
                progress: progress,
                completed: completedTasks,
                total: totalTasks,
              ),

              const SizedBox(height: 24),

              // Motivational Quote
              MotivationalQuoteCard(quote: quote),

              const SizedBox(height: 32),

              // Tasks Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Tasks',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.1),
                          theme.colorScheme.secondary.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '$totalTasks tasks',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Tasks List
              if (todayTasks.isEmpty)
                _buildEmptyState(context)
              else
                ...todayTasks.map((task) => TaskCard(
                  task: task,
                  onToggle: () {
                    ref.read(taskProvider.notifier).toggleTask(task.id);
                  },
                  onEdit: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddTaskModal(
                        task: task,
                        onTaskSaved: (updatedTask) {
                          ref.read(taskProvider.notifier).updateTask(updatedTask);
                        },
                      ),
                    );
                  },
                  onDelete: () {
                    ref.read(taskProvider.notifier).deleteTask(task.id);
                  },
                )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddTaskModal(
              onTaskSaved: (task) {
                ref.read(taskProvider.notifier).addTask(task);
              },
            ),
          );
        },
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.task_alt,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No tasks for today',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first task',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final days = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];

    return '${days[now.weekday % 7]}, ${months[now.month - 1]} ${now.day}';
  }
}
