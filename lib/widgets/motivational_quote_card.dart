// import 'package:flutter/material.dart';
//
// class MotivationalQuoteCard extends StatelessWidget {
//   final String quote;
//
//   const MotivationalQuoteCard({
//     super.key,
//     required this.quote,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             theme.colorScheme.secondary.withOpacity(0.1),
//             theme.primaryColor.withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: theme.colorScheme.secondary.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.secondary.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.format_quote,
//                   color: theme.colorScheme.secondary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'Daily Motivation',
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: theme.colorScheme.secondary,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             quote,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontStyle: FontStyle.italic,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
//
// class MotivationalQuoteCard extends StatelessWidget {
//   final String quote;
//
//   const MotivationalQuoteCard({
//     super.key,
//     required this.quote,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     // Use the same gradient colors as your profile card for consistency
//     final primaryColor = theme.colorScheme.primary;
//     final secondaryColor = theme.colorScheme.secondary;
//
//     // We split the quote string to separate the quote from the author
//     final parts = quote.split(' - ');
//     final quoteText = parts.length > 1 ? parts[0] : quote;
//     final author = parts.length > 1 ? parts[1] : 'Unknown';
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             primaryColor,
//             secondaryColor,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.4),
//             blurRadius: 25,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.format_quote_rounded,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Daily Inspiration',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               // You can add a category tag here later if you expand your quote provider
//             ],
//           ),
//           const SizedBox(height: 24),
//           Text(
//             '"$quoteText"',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               height: 1.4,
//               shadows: [
//                 Shadow(
//                   blurRadius: 10.0,
//                   color: Colors.black26,
//                   offset: Offset(2.0, 2.0),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Container(
//                 width: 3,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 margin: const EdgeInsets.only(right: 12),
//               ),
//               Text(
//                 '— $author',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
//
// class MotivationalQuoteCard extends StatelessWidget {
//   final String quote;
//
//   const MotivationalQuoteCard({
//     super.key,
//     required this.quote,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primaryColor = theme.colorScheme.primary;
//     final secondaryColor = theme.colorScheme.secondary;
//
//     final parts = quote.split(' - ');
//     final quoteText = parts.length > 1 ? parts[0] : quote;
//     final author = parts.length > 1 ? parts[1] : 'Unknown';
//
//     return Container(
//       width: double.infinity,
//       // Reduced vertical padding to make the card shorter
//       padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             primaryColor,
//             secondaryColor,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 // Reduced size of the icon container
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.format_quote_rounded,
//                   color: Colors.white,
//                   size: 18, // Reduced icon size
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'Daily Inspiration',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16, // Reduced font size
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16), // Reduced spacing
//           Text(
//             '"$quoteText"',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 18, // Reduced font size for the quote
//               fontWeight: FontWeight.bold,
//               height: 1.4,
//               shadows: [
//                 Shadow(
//                   blurRadius: 8.0,
//                   color: Colors.black26,
//                   offset: Offset(1.0, 1.0),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12), // Reduced spacing
//           Row(
//             children: [
//               Container(
//                 width: 3,
//                 height: 20, // Reduced height of the bar
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 margin: const EdgeInsets.only(right: 12),
//               ),
//               Text(
//                 '— $author',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 15, // Reduced font size
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
//
// class MotivationalQuoteCard extends StatelessWidget {
//   final String quote;
//
//   const MotivationalQuoteCard({
//     super.key,
//     required this.quote,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primaryColor = theme.colorScheme.primary;
//     final secondaryColor = theme.colorScheme.secondary;
//
//     final parts = quote.split(' - ');
//     final quoteText = parts.length > 1 ? parts[0] : quote;
//     final author = parts.length > 1 ? parts[1] : 'Unknown';
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             primaryColor,
//             secondaryColor,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.format_quote_rounded,
//                   color: Colors.white,
//                   size: 18,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'Daily Inspiration',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // --- FONT AND STYLE UPDATED HERE ---
//           Text(
//             '"$quoteText"',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20, // Slightly increased size for the new font
//               fontFamily: 'Lora', // Using the new custom font
//               fontStyle: FontStyle.italic,
//               fontWeight: FontWeight.w500, // A lighter, more elegant weight
//               height: 1.5,
//               shadows: [
//                 Shadow(
//                   blurRadius: 8.0,
//                   color: Colors.black26,
//                   offset: Offset(1.0, 1.0),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Container(
//                 width: 3,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 margin: const EdgeInsets.only(right: 12),
//               ),
//               Text(
//                 '— $author',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 15,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';

class MotivationalQuoteCard extends StatelessWidget {
  final String quote;

  const MotivationalQuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    final parts = quote.split(' - ');
    final quoteText = parts.length > 1 ? parts[0] : quote;
    final author = parts.length > 1 ? parts[1] : 'Unknown';

    return Container(
      width: double.infinity,
      // Reduced vertical padding for a more compact card
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.format_quote_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Daily Inspiration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Reduced spacing
          Text(
            '"$quoteText"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18, // Reduced font size to balance the new font's height
              fontFamily: 'Lora',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              height: 1.4, // Adjusted line height
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10), // Reduced spacing
          Row(
            children: [
              Container(
                width: 3,
                height: 18, // Reduced height of the bar
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(right: 12),
              ),
              Text(
                '— $author',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14, // Reduced font size
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
