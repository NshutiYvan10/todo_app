// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/task_provider.dart';
// import '../models/task.dart';
// import '../widgets/task_card.dart';
//
// enum TaskFilter { all, completed, pending, overdue }
// enum TaskSort { date, priority, title }
//
// final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
// final taskSortProvider = StateProvider<TaskSort>((ref) => TaskSort.date);
//
// class TasksScreen extends ConsumerWidget {
//   const TasksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final allTasks = ref.watch(taskProvider);
//     final filter = ref.watch(taskFilterProvider);
//     final sort = ref.watch(taskSortProvider);
//
//     final filteredTasks = _filterTasks(allTasks, filter);
//     final sortedTasks = _sortTasks(filteredTasks, sort);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'All Tasks',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           PopupMenuButton<TaskSort>(
//             icon: const Icon(Icons.sort),
//             onSelected: (sort) {
//               ref.read(taskSortProvider.notifier).state = sort;
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: TaskSort.date,
//                 child: Text('Sort by Date'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.priority,
//                 child: Text('Sort by Priority'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.title,
//                 child: Text('Sort by Title'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildFilterChips(context, ref, filter),
//           Expanded(
//             child: sortedTasks.isEmpty
//                 ? _buildEmptyState(filter)
//                 : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: sortedTasks.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: TaskCard(task: sortedTasks[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterChips(BuildContext context, WidgetRef ref, TaskFilter currentFilter) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: TaskFilter.values.map((filter) {
//           final isSelected = filter == currentFilter;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: FilterChip(
//               label: Text(_getFilterLabel(filter)),
//               selected: isSelected,
//               onSelected: (selected) {
//                 ref.read(taskFilterProvider.notifier).state = filter;
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(TaskFilter filter) {
//     String message;
//     IconData icon;
//
//     switch (filter) {
//       case TaskFilter.completed:
//         message = 'No completed tasks yet';
//         icon = Icons.task_alt;
//         break;
//       case TaskFilter.pending:
//         message = 'No pending tasks';
//         icon = Icons.pending_actions;
//         break;
//       case TaskFilter.overdue:
//         message = 'No overdue tasks';
//         icon = Icons.schedule;
//         break;
//       default:
//         message = 'No tasks yet';
//         icon = Icons.task;
//     }
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getFilterLabel(TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.all:
//         return 'All';
//       case TaskFilter.completed:
//         return 'Completed';
//       case TaskFilter.pending:
//         return 'Pending';
//       case TaskFilter.overdue:
//         return 'Overdue';
//     }
//   }
//
//   List<Task> _filterTasks(List<Task> tasks, TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.completed:
//         return tasks.where((task) => task.isCompleted).toList();
//       case TaskFilter.pending:
//         return tasks.where((task) => !task.isCompleted && !task.isOverdue).toList();
//       case TaskFilter.overdue:
//         return tasks.where((task) => task.isOverdue).toList();
//       default:
//         return tasks;
//     }
//   }
//
//   List<Task> _sortTasks(List<Task> tasks, TaskSort sort) {
//     final sortedTasks = List<Task>.from(tasks);
//
//     switch (sort) {
//       case TaskSort.date:
//         sortedTasks.sort((a, b) {
//           if (a.dueDate == null && b.dueDate == null) return 0;
//           if (a.dueDate == null) return 1;
//           if (b.dueDate == null) return -1;
//           return a.dueDate!.compareTo(b.dueDate!);
//         });
//         break;
//       case TaskSort.priority:
//         sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
//         break;
//       case TaskSort.title:
//         sortedTasks.sort((a, b) => a.title.compareTo(b.title));
//         break;
//     }
//
//     return sortedTasks;
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/task.dart';
// import '../providers/task_provider.dart';
// import '../widgets/add_task_modal.dart';
// import '../widgets/task_card.dart';
//
// enum TaskFilter { all, completed, pending, overdue }
// enum TaskSort { date, priority, title }
//
// final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
// final taskSortProvider = StateProvider<TaskSort>((ref) => TaskSort.date);
//
// class TasksScreen extends ConsumerWidget {
//   const TasksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final allTasks = ref.watch(taskProvider);
//     final filter = ref.watch(taskFilterProvider);
//     final sort = ref.watch(taskSortProvider);
//
//     final filteredTasks = _filterTasks(allTasks, filter);
//     final sortedTasks = _sortTasks(filteredTasks, sort);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'All Tasks',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           PopupMenuButton<TaskSort>(
//             icon: const Icon(Icons.sort),
//             onSelected: (sort) {
//               ref.read(taskSortProvider.notifier).state = sort;
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: TaskSort.date,
//                 child: Text('Sort by Date'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.priority,
//                 child: Text('Sort by Priority'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.title,
//                 child: Text('Sort by Title'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildFilterChips(context, ref, filter),
//           Expanded(
//             child: sortedTasks.isEmpty
//                 ? _buildEmptyState(filter)
//                 : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: sortedTasks.length,
//               itemBuilder: (context, index) {
//                 final task = sortedTasks[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: TaskCard(
//                     task: task,
//                     onToggle: () {
//                       ref
//                           .read(taskProvider.notifier)
//                           .toggleTask(task.id);
//                     },
//                     onEdit: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) => AddTaskModal(
//                           task: task,
//                           onTaskSaved: (updatedTask) {
//                             ref
//                                 .read(taskProvider.notifier)
//                                 .updateTask(updatedTask);
//                           },
//                         ),
//                       );
//                     },
//                     onDelete: () {
//                       ref
//                           .read(taskProvider.notifier)
//                           .deleteTask(task.id);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterChips(
//       BuildContext context, WidgetRef ref, TaskFilter currentFilter) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: TaskFilter.values.map((filter) {
//           final isSelected = filter == currentFilter;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: FilterChip(
//               label: Text(_getFilterLabel(filter)),
//               selected: isSelected,
//               onSelected: (selected) {
//                 ref.read(taskFilterProvider.notifier).state = filter;
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(TaskFilter filter) {
//     String message;
//     IconData icon;
//
//     switch (filter) {
//       case TaskFilter.completed:
//         message = 'No completed tasks yet';
//         icon = Icons.task_alt;
//         break;
//       case TaskFilter.pending:
//         message = 'No pending tasks';
//         icon = Icons.pending_actions;
//         break;
//       case TaskFilter.overdue:
//         message = 'No overdue tasks';
//         icon = Icons.schedule;
//         break;
//       default:
//         message = 'No tasks yet';
//         icon = Icons.task;
//     }
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getFilterLabel(TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.all:
//         return 'All';
//       case TaskFilter.completed:
//         return 'Completed';
//       case TaskFilter.pending:
//         return 'Pending';
//       case TaskFilter.overdue:
//         return 'Overdue';
//     }
//   }
//
//   List<Task> _filterTasks(List<Task> tasks, TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.completed:
//         return tasks.where((task) => task.isCompleted).toList();
//       case TaskFilter.pending:
//         return tasks
//             .where((task) => !task.isCompleted && !task.isOverdue)
//             .toList();
//       case TaskFilter.overdue:
//         return tasks.where((task) => task.isOverdue).toList();
//       default:
//         return tasks;
//     }
//   }
//
//   List<Task> _sortTasks(List<Task> tasks, TaskSort sort) {
//     final sortedTasks = List<Task>.from(tasks);
//
//     switch (sort) {
//       case TaskSort.date:
//         sortedTasks.sort((a, b) {
//           if (a.dueDate == null && b.dueDate == null) return 0;
//           if (a.dueDate == null) return 1;
//           if (b.dueDate == null) return -1;
//           return a.dueDate!.compareTo(b.dueDate!);
//         });
//         break;
//       case TaskSort.priority:
//         sortedTasks
//             .sort((a, b) => b.priority.index.compareTo(a.priority.index));
//         break;
//       case TaskSort.title:
//         sortedTasks.sort((a, b) => a.title.compareTo(b.title));
//         break;
//     }
//
//     return sortedTasks;
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/task.dart';
// import '../providers/task_provider.dart';
// import '../widgets/add_task_modal.dart';
// import '../widgets/task_card.dart';
//
// enum TaskFilter { all, completed, pending, overdue }
// enum TaskSort { date, priority, title }
//
// final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
// final taskSortProvider = StateProvider<TaskSort>((ref) => TaskSort.date);
//
// class TasksScreen extends ConsumerWidget {
//   const TasksScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final allTasks = ref.watch(taskProvider);
//     final filter = ref.watch(taskFilterProvider);
//     final sort = ref.watch(taskSortProvider);
//
//     final filteredTasks = _filterTasks(allTasks, filter);
//     final sortedTasks = _sortTasks(filteredTasks, sort);
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'My Tasks',
//           style: theme.textTheme.displaySmall?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           PopupMenuButton<TaskSort>(
//             icon: Icon(
//               Icons.sort,
//               color: theme.textTheme.bodyLarge?.color,
//             ),
//             onSelected: (sort) {
//               ref.read(taskSortProvider.notifier).state = sort;
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: TaskSort.date,
//                 child: Text('Sort by Date'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.priority,
//                 child: Text('Sort by Priority'),
//               ),
//               const PopupMenuItem(
//                 value: TaskSort.title,
//                 child: Text('Sort by Title'),
//               ),
//             ],
//           ),
//           const SizedBox(width: 10), // Added padding for the sort icon
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildFilterChips(context, ref, filter), // This method is now updated
//           Expanded(
//             child: sortedTasks.isEmpty
//                 ? _buildEmptyState(filter)
//                 : ListView.builder(
//               padding: const EdgeInsets.only(
//                   left: 16, right: 16, top: 16, bottom: 100),
//               itemCount: sortedTasks.length,
//               itemBuilder: (context, index) {
//                 final task = sortedTasks[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: TaskCard(
//                     task: task,
//                     onToggle: () {
//                       ref
//                           .read(taskProvider.notifier)
//                           .toggleTask(task.id);
//                     },
//                     onEdit: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) => AddTaskModal(
//                           task: task,
//                           onTaskSaved: (updatedTask) {
//                             ref
//                                 .read(taskProvider.notifier)
//                                 .updateTask(updatedTask);
//                           },
//                         ),
//                       );
//                     },
//                     onDelete: () {
//                       ref
//                           .read(taskProvider.notifier)
//                           .deleteTask(task.id);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- THIS IS THE NEW, VISUALLY UPGRADED WIDGET ---
//   Widget _buildFilterChips(
//       BuildContext context, WidgetRef ref, TaskFilter currentFilter) {
//     final theme = Theme.of(context);
//     return Container(
//       height: 50, // Reduced height for a tighter design
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       // Replaced ListView with a Row to ensure all items are visible
//       child: Row(
//         children: TaskFilter.values.map((filter) {
//           final isSelected = filter == currentFilter;
//           // Wrapped each item in an Expanded widget to distribute space evenly
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 ref.read(taskFilterProvider.notifier).state = filter;
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 // Using symmetrical margin for clean spacing between items
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   gradient: isSelected
//                       ? LinearGradient(
//                     colors: [
//                       theme.colorScheme.primary,
//                       theme.colorScheme.secondary,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                       : null,
//                   color: isSelected ? null : theme.cardColor,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: isSelected
//                           ? theme.colorScheme.primary.withOpacity(0.2)
//                           : Colors.black.withOpacity(0.05),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     )
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   _getFilterLabel(filter),
//                   style: TextStyle(
//                     color: isSelected
//                         ? Colors.white
//                         : theme.textTheme.bodyLarge?.color,
//                     fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(TaskFilter filter) {
//     String message;
//     IconData icon;
//
//     switch (filter) {
//       case TaskFilter.completed:
//         message = 'No completed tasks yet';
//         icon = Icons.task_alt_outlined;
//         break;
//       case TaskFilter.pending:
//         message = 'You have no pending tasks';
//         icon = Icons.pending_actions_outlined;
//         break;
//       case TaskFilter.overdue:
//         message = 'Nothing is overdue!';
//         icon = Icons.history_toggle_off_outlined;
//         break;
//       default:
//         message = 'No tasks found';
//         icon = Icons.search_off_outlined;
//     }
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getFilterLabel(TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.all:
//         return 'All';
//       case TaskFilter.completed:
//         return 'Completed';
//       case TaskFilter.pending:
//         return 'Pending';
//       case TaskFilter.overdue:
//         return 'Overdue';
//     }
//   }
//
//   List<Task> _filterTasks(List<Task> tasks, TaskFilter filter) {
//     switch (filter) {
//       case TaskFilter.completed:
//         return tasks.where((task) => task.isCompleted).toList();
//       case TaskFilter.pending:
//         return tasks
//             .where((task) => !task.isCompleted && !task.isOverdue)
//             .toList();
//       case TaskFilter.overdue:
//         return tasks.where((task) => task.isOverdue).toList();
//       default:
//         return tasks;
//     }
//   }
//
//   List<Task> _sortTasks(List<Task> tasks, TaskSort sort) {
//     final sortedTasks = List<Task>.from(tasks);
//
//     switch (sort) {
//       case TaskSort.date:
//         sortedTasks.sort((a, b) {
//           if (a.dueDate == null && b.dueDate == null) return 0;
//           if (a.dueDate == null) return 1;
//           if (b.dueDate == null) return -1;
//           return a.dueDate!.compareTo(b.dueDate!);
//         });
//         break;
//       case TaskSort.priority:
//         sortedTasks
//             .sort((a, b) => b.priority.index.compareTo(a.priority.index));
//         break;
//       case TaskSort.title:
//         sortedTasks.sort((a, b) => a.title.compareTo(b.title));
//         break;
//     }
//
//     return sortedTasks;
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/add_task_modal.dart';
import '../widgets/task_card.dart';

enum TaskFilter { all, completed, pending, overdue }
enum TaskSort { date, priority, title }

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
final taskSortProvider = StateProvider<TaskSort>((ref) => TaskSort.date);

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(taskProvider);
    final filter = ref.watch(taskFilterProvider);
    final sort = ref.watch(taskSortProvider);

    final filteredTasks = _filterTasks(allTasks, filter);
    final sortedTasks = _sortTasks(filteredTasks, sort);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<TaskSort>(
            icon: Icon(
              Icons.sort,
              color: theme.textTheme.bodyLarge?.color,
            ),
            onSelected: (sort) {
              ref.read(taskSortProvider.notifier).state = sort;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskSort.date,
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                value: TaskSort.priority,
                child: Text('Sort by Priority'),
              ),
              const PopupMenuItem(
                value: TaskSort.title,
                child: Text('Sort by Title'),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildFilterChips(context, ref, filter),
          Expanded(
            child: sortedTasks.isEmpty
                ? _buildEmptyState(filter)
                : ListView.builder(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 100),
              itemCount: sortedTasks.length,
              itemBuilder: (context, index) {
                final task = sortedTasks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TaskCard(
                    task: task,
                    onToggle: () {
                      ref
                          .read(taskProvider.notifier)
                          .toggleTask(task.id);
                    },
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // <-- FIX 1 HERE
                        backgroundColor: Colors.transparent,
                        builder: (context) => AddTaskModal(
                          task: task,
                          onTaskSaved: (updatedTask) {
                            ref
                                .read(taskProvider.notifier)
                                .updateTask(updatedTask);
                          },
                        ),
                      );
                    },
                    onDelete: () {
                      ref
                          .read(taskProvider.notifier)
                          .deleteTask(task.id);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
      BuildContext context, WidgetRef ref, TaskFilter currentFilter) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: TaskFilter.values.map((filter) {
          final isSelected = filter == currentFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(taskFilterProvider.notifier).state = filter;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: isSelected ? null : theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? theme.colorScheme.primary.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _getFilterLabel(filter),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : theme.textTheme.bodyLarge?.color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(TaskFilter filter) {
    String message;
    IconData icon;
    switch (filter) {
      case TaskFilter.completed:
        message = 'No completed tasks yet';
        icon = Icons.task_alt_outlined;
        break;
      case TaskFilter.pending:
        message = 'You have no pending tasks';
        icon = Icons.pending_actions_outlined;
        break;
      case TaskFilter.overdue:
        message = 'Nothing is overdue!';
        icon = Icons.history_toggle_off_outlined;
        break;
      default:
        message = 'No tasks found';
        icon = Icons.search_off_outlined;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterLabel(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return 'All';
      case TaskFilter.completed:
        return 'Completed';
      case TaskFilter.pending:
        return 'Pending';
      case TaskFilter.overdue:
        return 'Overdue';
    }
  }

  List<Task> _filterTasks(List<Task> tasks, TaskFilter filter) {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return tasks
            .where((task) => !task.isCompleted && !task.isOverdue)
            .toList();
      case TaskFilter.overdue:
        return tasks.where((task) => task.isOverdue).toList();
      default:
        return tasks;
    }
  }

  List<Task> _sortTasks(List<Task> tasks, TaskSort sort) {
    final sortedTasks = List<Task>.from(tasks);
    switch (sort) {
      case TaskSort.date:
        sortedTasks.sort((a, b) {
          if (a.dueDate == null && b.dueDate == null) return 0;
          if (a.dueDate == null) return 1;
          if (b.dueDate == null) return -1;
          return a.dueDate!.compareTo(b.dueDate!);
        });
        break;
      case TaskSort.priority:
        sortedTasks
            .sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case TaskSort.title:
        sortedTasks.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
    return sortedTasks; // <-- FIX 2 HERE
  }
}