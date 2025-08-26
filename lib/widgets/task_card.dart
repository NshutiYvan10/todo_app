// import 'package:flutter/material.dart';
// import '../models/task.dart';
//
// class TaskCard extends StatelessWidget {
//   final Task task;
//   final VoidCallback onToggle;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//
//   const TaskCard({
//     super.key,
//     required this.task,
//     required this.onToggle,
//     required this.onEdit,
//     required this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey[800] : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         border: Border.all(
//           color: task.isCompleted
//               ? Colors.green.withOpacity(0.3)
//               : task.priority.color.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onToggle,
//           borderRadius: BorderRadius.circular(16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Checkbox
//                 GestureDetector(
//                   onTap: onToggle,
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: task.isCompleted
//                             ? Colors.green
//                             : task.priority.color,
//                         width: 2,
//                       ),
//                       color: task.isCompleted
//                           ? Colors.green
//                           : Colors.transparent,
//                     ),
//                     child: task.isCompleted
//                         ? const Icon(
//                       Icons.check,
//                       color: Colors.white,
//                       size: 16,
//                     )
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//
//                 // Task Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title
//                       Text(
//                         task.title,
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           decoration: task.isCompleted
//                               ? TextDecoration.lineThrough
//                               : null,
//                           color: task.isCompleted
//                               ? Colors.grey
//                               : null,
//                         ),
//                       ),
//
//                       // Description
//                       if (task.description != null && task.description!.isNotEmpty)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Text(
//                             task.description!,
//                             style: theme.textTheme.bodySmall?.copyWith(
//                               color: task.isCompleted
//                                   ? Colors.grey
//                                   : theme.textTheme.bodySmall?.color,
//                               decoration: task.isCompleted
//                                   ? TextDecoration.lineThrough
//                                   : null,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//
//                       // Due Date and Category
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           // Category
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: task.category.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   task.category.icon,
//                                   size: 12,
//                                   color: task.category.color,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   task.category.displayName,
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     color: task.category.color,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(width: 8),
//
//                           // Due Date
//                           if (task.dueDate != null)
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: task.isOverdue
//                                     ? Colors.red.withOpacity(0.1)
//                                     : Colors.blue.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.schedule,
//                                     size: 12,
//                                     color: task.isOverdue
//                                         ? Colors.red
//                                         : Colors.blue,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     _formatDate(task.dueDate!),
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: task.isOverdue
//                                           ? Colors.red
//                                           : Colors.blue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Priority Indicator
//                 Container(
//                   width: 4,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: task.priority.color,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 // Actions
//                 PopupMenuButton<String>(
//                   onSelected: (value) {
//                     switch (value) {
//                       case 'edit':
//                         onEdit();
//                         break;
//                       case 'delete':
//                         onDelete();
//                         break;
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     const PopupMenuItem(
//                       value: 'edit',
//                       child: Row(
//                         children: [
//                           Icon(Icons.edit, size: 16),
//                           SizedBox(width: 8),
//                           Text('Edit'),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: 'delete',
//                       child: Row(
//                         children: [
//                           Icon(Icons.delete, size: 16, color: Colors.red),
//                           SizedBox(width: 8),
//                           Text('Delete', style: TextStyle(color: Colors.red)),
//                         ],
//                       ),
//                     ),
//                   ],
//                   child: const Icon(Icons.more_vert),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final taskDate = DateTime(date.year, date.month, date.day);
//
//     if (taskDate.isAtSameMomentAs(today)) {
//       return 'Today';
//     } else if (taskDate.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
//       return 'Tomorrow';
//     } else if (taskDate.isBefore(today)) {
//       final difference = today.difference(taskDate).inDays;
//       return '$difference days ago';
//     } else {
//       return '${date.day}/${date.month}';
//     }
//   }
// }



import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/priority.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: task.isCompleted
              ? Colors.green.withOpacity(0.3)
              : task.priority.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Checkbox
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: task.isCompleted
                            ? Colors.green
                            : task.priority.color,
                        width: 2,
                      ),
                      color:
                      task.isCompleted ? Colors.green : Colors.transparent,
                    ),
                    child: task.isCompleted
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                        : null,
                  ),
                ),
                const SizedBox(width: 16),

                // Task Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        task.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isCompleted ? Colors.grey : null,
                        ),
                      ),

                      // Description
                      if (task.description != null &&
                          task.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            task.description!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: task.isCompleted
                                  ? Colors.grey
                                  : theme.textTheme.bodySmall?.color,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      // Due Date and Category
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Category
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: task.category.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  task.category.icon,
                                  size: 12,
                                  color: task.category.color,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.category.displayName,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: task.category.color,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Due Date
                          if (task.dueDate != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: task.isOverdue
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 12,
                                    color: task.isOverdue
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatDate(task.dueDate!),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: task.isOverdue
                                          ? Colors.red
                                          : Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Priority Indicator
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: task.priority.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(width: 12),

                // Actions
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onEdit();
                        break;
                      case 'delete':
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);

    if (taskDate.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (taskDate.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else if (taskDate.isBefore(today)) {
      final difference = today.difference(taskDate).inDays;
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}