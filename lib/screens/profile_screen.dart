// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/task_provider.dart';
// import '../providers/theme_provider.dart';
// import '../providers/auth_provider.dart';
// import '../widgets/productivity_chart.dart';
// import '../widgets/stats_card.dart';
// import '../widgets/edit_profile_modal.dart';
// import '../screens/auth/login_screen.dart';
//
// class ProfileScreen extends ConsumerWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stats = ref.watch(taskStatsProvider);
//     final themeMode = ref.watch(themeModeProvider);
//     final authState = ref.watch(authProvider);
//
//     if (authState is! Authenticated) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     final user = authState.user;
//     final tasks = ref.watch(taskProvider);
//     final completedTasks = tasks.where((task) => task.isCompleted).length;
//     final totalTasks = tasks.length;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(
//             left: 20,
//             right: 20,
//             top: 20,
//             bottom: 120, // Space for floating navigation
//           ),
//           child: Column(
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Profile',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) => const EditProfileModal(),
//                       );
//                     },
//                     icon: const Icon(Icons.edit),
//                     style: IconButton.styleFrom(
//                       backgroundColor: Theme.of(context).colorScheme.surface,
//                       padding: const EdgeInsets.all(12),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 32),
//
//               // User Info Card
//               Container(
//                 height: 140,
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).colorScheme.primary,
//                       Theme.of(context).colorScheme.secondary,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: user.profileImage != null
//                           ? ClipRRect(
//                         borderRadius: BorderRadius.circular(24),
//                         child: Image.network(
//                           user.profileImage!,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return _buildDefaultAvatar(user.name);
//                           },
//                         ),
//                       )
//                           : _buildDefaultAvatar(user.name),
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             user.name,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             user.email,
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           if (user.bio != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                               user.bio!,
//                               style: const TextStyle(
//                                 color: Colors.white60,
//                                 fontSize: 14,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               // Statistics Cards
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildStatCard(
//                       context,
//                       'Total Tasks',
//                       totalTasks.toString(),
//                       Icons.task_alt,
//                       Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildStatCard(
//                       context,
//                       'Completed',
//                       completedTasks.toString(),
//                       Icons.check_circle,
//                       Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 16),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildStatCard(
//                       context,
//                       'Pending',
//                       (totalTasks - completedTasks).toString(),
//                       Icons.pending,
//                       Colors.orange,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildStatCard(
//                       context,
//                       'Success Rate',
//                       totalTasks > 0 ? '${((completedTasks / totalTasks) * 100).round()}%' : '0%',
//                       Icons.trending_up,
//                       Colors.purple,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 32),
//
//               // Productivity Chart
//               Text(
//                 'Productivity Trends',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
//                       Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 15,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: ProductivityChart(stats: stats),
//               ),
//
//               const SizedBox(height: 32),
//
//               // Settings Section
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     _buildSettingsTile(
//                       context,
//                       'Dark Mode',
//                       'Toggle dark/light theme',
//                       Icons.dark_mode,
//                       trailing: Switch(
//                         value: themeMode == ThemeMode.dark,
//                         onChanged: (value) {
//                           ref.read(themeModeProvider.notifier).setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//                         },
//                         activeColor: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                     _buildDivider(context),
//                     _buildSettingsTile(
//                       context,
//                       'Notifications',
//                       'Manage your notifications',
//                       Icons.notifications,
//                       onTap: () {
//                         // TODO: Implement notifications settings
//                       },
//                     ),
//                     _buildDivider(context),
//                     _buildSettingsTile(
//                       context,
//                       'Privacy',
//                       'Privacy and security settings',
//                       Icons.privacy_tip,
//                       onTap: () {
//                         // TODO: Implement privacy settings
//                       },
//                     ),
//                     _buildDivider(context),
//                     _buildSettingsTile(
//                       context,
//                       'Help & Support',
//                       'Get help and contact support',
//                       Icons.help,
//                       onTap: () {
//                         // TODO: Implement help & support
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               // Sign Out Button
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.red.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Colors.red.withOpacity(0.3),
//                     width: 1,
//                   ),
//                 ),
//                 child: TextButton.icon(
//                   onPressed: () {
//                     _showSignOutDialog(context, ref);
//                   },
//                   icon: const Icon(
//                     Icons.logout,
//                     color: Colors.red,
//                   ),
//                   label: const Text(
//                     'Sign Out',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDefaultAvatar(String name) {
//     return Center(
//       child: Text(
//         name.split(' ').map((n) => n.isNotEmpty ? n[0] : '').take(2).join().toUpperCase(),
//         style: const TextStyle(
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard(
//       BuildContext context,
//       String title,
//       String value,
//       IconData icon,
//       Color color,
//       ) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: Theme.of(context).textTheme.bodySmall?.color,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingsTile(
//       BuildContext context,
//       String title,
//       String subtitle,
//       IconData icon, {
//         Widget? trailing,
//         VoidCallback? onTap,
//       }) {
//     return ListTile(
//       onTap: onTap,
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary.withOpacity(0.2),
//               Theme.of(context).colorScheme.secondary.withOpacity(0.2),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(
//           icon,
//           size: 20,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//       ),
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: Theme.of(context).textTheme.bodySmall,
//       ),
//       trailing: trailing ?? const Icon(Icons.chevron_right),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//     );
//   }
//
//   Widget _buildDivider(BuildContext context) {
//     return Divider(
//       height: 1,
//       color: Theme.of(context).dividerColor.withOpacity(0.1),
//       indent: 60,
//       endIndent: 20,
//     );
//   }
//
//   void _showSignOutDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Text('Sign Out'),
//           content: const Text('Are you sure you want to sign out?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 ref.read(authProvider.notifier).signOut();
//               },
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.red,
//               ),
//               child: const Text('Sign Out'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/productivity_chart.dart';
import '../widgets/edit_profile_modal.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(taskStatsProvider);
    final themeMode = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);

    if (authState is! Authenticated) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = authState.user;
    final tasks = ref.watch(taskProvider);
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 120, // Space for floating navigation
          ),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const EditProfileModal(),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // User Info Card
              Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: user.profileImage != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          user.profileImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultAvatar(user.name);
                          },
                        ),
                      )
                          : _buildDefaultAvatar(user.name),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (user.bio != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              user.bio!,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Total Tasks',
                      totalTasks.toString(),
                      Icons.task_alt,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Completed',
                      completedTasks.toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Pending',
                      (totalTasks - completedTasks).toString(),
                      Icons.pending,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Success Rate',
                      totalTasks > 0
                          ? '${((completedTasks / totalTasks) * 100).round()}%'
                          : '0%',
                      Icons.trending_up,
                      Colors.purple,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Productivity Chart
              Text(
                'Productivity Trends',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.1),
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ProductivityChart(stats: stats),
              ),

              const SizedBox(height: 32),

              // Settings Section
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingsTile(
                      context,
                      'Dark Mode',
                      'Toggle dark/light theme',
                      Icons.dark_mode,
                      trailing: Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).setTheme(
                              value ? ThemeMode.dark : ThemeMode.light);
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    _buildDivider(context),
                    _buildSettingsTile(
                      context,
                      'Notifications',
                      'Manage your notifications',
                      Icons.notifications,
                      onTap: () {
                        // TODO: Implement notifications settings
                      },
                    ),
                    _buildDivider(context),
                    _buildSettingsTile(
                      context,
                      'Privacy',
                      'Privacy and security settings',
                      Icons.privacy_tip,
                      onTap: () {
                        // TODO: Implement privacy settings
                      },
                    ),
                    _buildDivider(context),
                    _buildSettingsTile(
                      context,
                      'Help & Support',
                      'Get help and contact support',
                      Icons.help,
                      onTap: () {
                        // TODO: Implement help & support
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Sign Out Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    _showSignOutDialog(context, ref);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Center(
      child: Text(
        name
            .split(' ')
            .map((n) => n.isNotEmpty ? n[0] : '')
            .take(2)
            .join()
            .toUpperCase(),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon, {
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).dividerColor.withOpacity(0.1),
      indent: 60,
      endIndent: 20,
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(authProvider.notifier).signOut();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}