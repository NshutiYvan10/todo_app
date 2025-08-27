// import 'package:flutter/material.dart';
//
// class ProgressIndicatorWidget extends StatelessWidget {
//   final double progress;
//   final int completed;
//   final int total;
//
//   const ProgressIndicatorWidget({
//     super.key,
//     required this.progress,
//     required this.completed,
//     required this.total,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             theme.primaryColor.withOpacity(0.1),
//             theme.colorScheme.secondary.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.primaryColor.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Today\'s Progress',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${(progress * 100).toInt()}%',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: theme.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           // Progress Bar
//           Container(
//             height: 8,
//             decoration: BoxDecoration(
//               color: isDark ? Colors.grey[700] : Colors.grey[200],
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: FractionallySizedBox(
//               alignment: Alignment.centerLeft,
//               widthFactor: progress,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       theme.primaryColor,
//                       theme.colorScheme.secondary,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildStatItem(
//                 context,
//                 'Completed',
//                 completed.toString(),
//                 Colors.green,
//               ),
//               _buildStatItem(
//                 context,
//                 'Remaining',
//                 (total - completed).toString(),
//                 Colors.orange,
//               ),
//               _buildStatItem(
//                 context,
//                 'Total',
//                 total.toString(),
//                 theme.primaryColor,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(
//       BuildContext context,
//       String label,
//       String value,
//       Color color,
//       ) {
//     final theme = Theme.of(context);
//
//     return Column(
//       children: [
//         Text(
//           value,
//           style: theme.textTheme.headlineSmall?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: theme.textTheme.bodySmall?.copyWith(
//             color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final int completed;
  final int total;

  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Progress',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- THIS IS THE CORRECTED PROGRESS BAR ---
          SizedBox(
            height: 8,
            child: Stack(
              children: [
                // The background of the progress bar
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // The foreground (progress) of the bar
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor,
                          theme.colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                context,
                'Completed',
                completed.toString(),
                Colors.green,
              ),
              _buildStatItem(
                context,
                'Remaining',
                (total - completed).toString(),
                Colors.orange,
              ),
              _buildStatItem(
                context,
                'Total',
                total.toString(),
                theme.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context,
      String label,
      String value,
      Color color,
      ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}