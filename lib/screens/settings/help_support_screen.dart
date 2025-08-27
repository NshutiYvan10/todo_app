// import 'package:flutter/material.dart';
//
// class HelpSupportScreen extends StatelessWidget {
//   const HelpSupportScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Help & Support',
//           style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20.0),
//         children: [
//           _buildSectionHeader(context, 'Frequently Asked Questions'),
//           _buildFaqTile(
//             context,
//             'How do I edit a task?',
//             'On the "Tasks" or "Today" screen, tap the three dots on the right side of a task card and select "Edit" to open the task editor.',
//           ),
//           _buildFaqTile(
//             context,
//             'How is my data stored?',
//             'All your task and profile data is stored securely and locally on your device. We do not have access to your data.',
//           ),
//           _buildFaqTile(
//             context,
//             'Can I sync my tasks across devices?',
//             'Currently, all data is stored locally. We are working on a secure cloud sync feature for a future update.',
//           ),
//           const SizedBox(height: 30),
//           _buildSectionHeader(context, 'Contact Us'),
//           _buildContactTile(
//             context,
//             'Email Support',
//             'support@taskflow.app',
//             Icons.email_outlined,
//           ),
//           _buildContactTile(
//             context,
//             'Report a Bug',
//             'bugs@taskflow.app',
//             Icons.bug_report_outlined,
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
//   Widget _buildFaqTile(BuildContext context, String question, String answer) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
//       ),
//       child: ExpansionTile(
//         title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(answer),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactTile(BuildContext context, String title, String subtitle, IconData icon) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: theme.colorScheme.primary),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//         subtitle: Text(subtitle),
//         onTap: () {
//           // In a real app, this would launch a mail client
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Launching email to: $subtitle')),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildSectionHeader(context, 'Frequently Asked Questions'),
          const SizedBox(height: 8),
          _buildFaqTile(
            context,
            'How do I edit a task?',
            'On the "Tasks" or "Today" screen, tap the three dots on the right side of a task card and select "Edit" to open the task editor.',
          ),
          const SizedBox(height: 12),
          _buildFaqTile(
            context,
            'How is my data stored?',
            'All your task and profile data is stored securely and locally on your device. We do not have access to your data.',
          ),
          const SizedBox(height: 12),
          _buildFaqTile(
            context,
            'Can I sync my tasks across devices?',
            'Currently, all data is stored locally. We are working on a secure cloud sync feature for a future update.',
          ),
          const SizedBox(height: 30),
          _buildSectionHeader(context, 'Contact Us'),
          const SizedBox(height: 8),
          _buildContactTile(
            context,
            'Email Support',
            'support@taskflow.app',
            Icons.email_outlined,
          ),
          const SizedBox(height: 12),
          _buildContactTile(
            context,
            'Report a Bug',
            'bugs@taskflow.app',
            Icons.bug_report_outlined,
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

  Widget _buildFaqTile(BuildContext context, String question, String answer) {
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
          )
        ],
      ),
      child: ExpansionTile(
        shape: const Border(), // Remove default expansion border
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, String title, String subtitle, IconData icon) {
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
          )
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Launching email to: $subtitle')),
          );
        },
      ),
    );
  }
}