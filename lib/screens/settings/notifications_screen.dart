// import 'package:flutter/material.dart';
//
// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Notifications',
//           style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20.0),
//         children: [
//           _buildSectionHeader(context, 'Task Reminders'),
//           _buildNotificationSwitchTile(
//             context: context,
//             title: 'Due Date Reminders',
//             subtitle: 'Get notified when a task is due soon.',
//             value: true, // Example value
//             onChanged: (val) {},
//           ),
//           _buildNotificationSwitchTile(
//             context: context,
//             title: 'Overdue Task Alerts',
//             subtitle: 'Get notified when a task becomes overdue.',
//             value: true, // Example value
//             onChanged: (val) {},
//           ),
//           const SizedBox(height: 20),
//           _buildSectionHeader(context, 'Daily Updates'),
//           _buildNotificationSwitchTile(
//             context: context,
//             title: 'Daily Summary',
//             subtitle: 'Receive a summary of your tasks for the day each morning.',
//             value: false, // Example value
//             onChanged: (val) {},
//           ),
//           const SizedBox(height: 20),
//           _buildSectionHeader(context, 'App Updates'),
//           _buildNotificationSwitchTile(
//             context: context,
//             title: 'Feature Announcements',
//             subtitle: 'Get notified about new features and app updates.',
//             value: true, // Example value
//             onChanged: (val) {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(BuildContext context, String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget _buildNotificationSwitchTile({
//     required BuildContext context,
//     required String title,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
//       ),
//       child: SwitchListTile(
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//         subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
//         value: value,
//         onChanged: onChanged,
//         activeColor: theme.colorScheme.primary,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Example state values
  bool dueDateReminders = true;
  bool overdueTaskAlerts = true;
  bool dailySummary = false;
  bool featureAnnouncements = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildSectionHeader(context, 'Task Reminders'),
          const SizedBox(height: 8),
          _buildNotificationSwitchTile(
            context: context,
            title: 'Due Date Reminders',
            subtitle: 'Get notified when a task is due soon.',
            icon: Icons.notifications_active_outlined,
            value: dueDateReminders,
            onChanged: (val) => setState(() => dueDateReminders = val),
          ),
          const SizedBox(height: 12),
          _buildNotificationSwitchTile(
            context: context,
            title: 'Overdue Task Alerts',
            subtitle: 'Get notified when a task becomes overdue.',
            icon: Icons.error_outline_rounded,
            value: overdueTaskAlerts,
            onChanged: (val) => setState(() => overdueTaskAlerts = val),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Daily Updates'),
          const SizedBox(height: 8),
          _buildNotificationSwitchTile(
            context: context,
            title: 'Daily Summary',
            subtitle: 'A morning brief of your day\'s tasks.',
            icon: Icons.wb_sunny_outlined,
            value: dailySummary,
            onChanged: (val) => setState(() => dailySummary = val),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'App Updates'),
          const SizedBox(height: 8),
          _buildNotificationSwitchTile(
            context: context,
            title: 'Feature Announcements',
            subtitle: 'Stay updated with the latest features.',
            icon: Icons.campaign_outlined,
            value: featureAnnouncements,
            onChanged: (val) => setState(() => featureAnnouncements = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNotificationSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        value: value,
        onChanged: onChanged,
        activeColor: theme.colorScheme.primary,
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}