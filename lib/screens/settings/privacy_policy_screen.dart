// import 'package:flutter/material.dart';
//
// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Privacy Policy',
//           style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Last updated: August 27, 2025',
//               style: theme.textTheme.bodySmall,
//             ),
//             const SizedBox(height: 24),
//             _buildPolicySection(
//               context,
//               '1. Information We Collect',
//               'This application is designed to store all your data locally on your device. We do not collect, transmit, or store any of your personal information, including your tasks, profile information, or usage data, on any external servers. All data you create remains under your control on your personal device.',
//             ),
//             _buildPolicySection(
//               context,
//               '2. How We Use Your Information',
//               'Since we do not collect your personal information, we do not use it for any purpose. The app uses on-device storage (Hive) solely for the purpose of providing you with the application\'s features, such as saving and managing your to-do lists.',
//             ),
//             _buildPolicySection(
//               context,
//               '3. Data Security',
//               'We take the security of your data seriously. All data is stored in a sandboxed, local database on your device, protected by the operating system\'s security measures. We do not have access to this data. You are responsible for the physical security of your device.',
//             ),
//             _buildPolicySection(
//               context,
//               '4. Changes to This Privacy Policy',
//               'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPolicySection(BuildContext context, String title, String content) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             content,
//             style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Last updated: August 27, 2025',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              context,
              '1. Information We Collect',
              'This application is designed to store all your data locally on your device. We do not collect, transmit, or store any of your personal information, including your tasks, profile information, or usage data, on any external servers. All data you create remains under your control on your personal device.',
            ),
            _buildPolicySection(
              context,
              '2. How We Use Your Information',
              'Since we do not collect your personal information, we do not use it for any purpose. The app uses on-device storage (Hive) solely for the purpose of providing you with the application\'s features, such as saving and managing your to-do lists.',
            ),
            _buildPolicySection(
              context,
              '3. Data Security',
              'We take the security of your data seriously. All data is stored in a sandboxed, local database on your device, protected by the operating system\'s security measures. We do not have access to this data. You are responsible for the physical security of your device.',
            ),
            _buildPolicySection(
              context,
              '4. Changes to This Privacy Policy',
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}