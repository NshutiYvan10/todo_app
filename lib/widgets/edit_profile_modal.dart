// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class EditProfileModal extends ConsumerStatefulWidget {
//   const EditProfileModal({super.key});
//
//   @override
//   ConsumerState<EditProfileModal> createState() => _EditProfileModalState();
// }
//
// class _EditProfileModalState extends ConsumerState<EditProfileModal>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _bioController = TextEditingController();
//   final _phoneController = TextEditingController();
//
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _initializeFormData();
//   }
//
//   void _initializeAnimations() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     ));
//
//     _animationController.forward();
//   }
//
//   void _initializeFormData() {
//     final authState = ref.read(authProvider);
//     if (authState is Authenticated) {
//       _nameController.text = authState.user.name;
//       _bioController.text = authState.user.bio ?? '';
//       _phoneController.text = authState.user.phone ?? '';
//     }
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _nameController.dispose();
//     _bioController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final authState = ref.watch(authProvider);
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return SlideTransition(
//           position: _slideAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.75,
//               decoration: BoxDecoration(
//                 color: isDark ? Colors.grey[900] : Colors.white,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildHeader(theme),
//                   Expanded(
//                     child: _buildForm(theme, authState),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildHeader(ThemeData theme) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             theme.primaryColor,
//             theme.primaryColor.withOpacity(0.8),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(24),
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.edit,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               'Edit Profile',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: const Icon(Icons.close, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildForm(ThemeData theme, AuthState authState) {
//     if (authState is! Authenticated) {
//       return const Center(child: Text('User not authenticated'));
//     }
//
//     final user = authState.user;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProfileImage(theme, user),
//             const SizedBox(height: 24),
//             _buildEmailField(theme, user),
//             const SizedBox(height: 20),
//             _buildNameField(theme),
//             const SizedBox(height: 20),
//             _buildBioField(theme),
//             const SizedBox(height: 20),
//             _buildPhoneField(theme),
//             const SizedBox(height: 30),
//             _buildSaveButton(theme),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileImage(ThemeData theme, user) {
//     return Center(
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundColor: theme.primaryColor.withOpacity(0.1),
//             backgroundImage: user.profileImage != null
//                 ? NetworkImage(user.profileImage!)
//                 : null,
//             child: user.profileImage == null
//                 ? Icon(
//               Icons.person,
//               size: 50,
//               color: theme.primaryColor,
//             )
//                 : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 // TODO: Implement image picker
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Image picker coming soon!'),
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmailField(ThemeData theme, user) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Email',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           initialValue: user.email,
//           decoration: InputDecoration(
//             hintText: 'Email address',
//             prefixIcon: const Icon(Icons.email),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             filled: true,
//             fillColor: theme.cardColor,
//           ),
//           enabled: false, // Email should not be editable
//           style: TextStyle(
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNameField(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Full Name',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _nameController,
//           decoration: InputDecoration(
//             hintText: 'Enter your full name',
//             prefixIcon: const Icon(Icons.person),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             filled: true,
//             fillColor: theme.cardColor,
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter your name';
//             }
//             return null;
//           },
//           textCapitalization: TextCapitalization.words,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBioField(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Bio',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _bioController,
//           decoration: InputDecoration(
//             hintText: 'Tell us about yourself...',
//             prefixIcon: const Icon(Icons.info),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             filled: true,
//             fillColor: theme.cardColor,
//           ),
//           maxLines: 3,
//           textCapitalization: TextCapitalization.sentences,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPhoneField(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Phone Number',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _phoneController,
//           decoration: InputDecoration(
//             hintText: 'Enter your phone number',
//             prefixIcon: const Icon(Icons.phone),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             filled: true,
//             fillColor: theme.cardColor,
//           ),
//           keyboardType: TextInputType.phone,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSaveButton(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _saveProfile,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: theme.primaryColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 2,
//         ),
//         child: _isLoading
//             ? const SizedBox(
//           height: 20,
//           width: 20,
//           child: CircularProgressIndicator(
//             strokeWidth: 2,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )
//             : const Text(
//           'Save Changes',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final success = await ref.read(authProvider.notifier).updateProfile(
//         name: _nameController.text.trim(),
//         bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
//         phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
//       );
//
//       if (success && mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile updated successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to update profile'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating profile: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
// import '../models/user.dart';
//
// class EditProfileModal extends ConsumerStatefulWidget {
//   const EditProfileModal({super.key});
//
//   @override
//   ConsumerState<EditProfileModal> createState() => _EditProfileModalState();
// }
//
// class _EditProfileModalState extends ConsumerState<EditProfileModal>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _bioController = TextEditingController();
//   final _phoneController = TextEditingController();
//
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _initializeFormData();
//   }
//
//   void _initializeAnimations() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     ));
//
//     _animationController.forward();
//   }
//
//   void _initializeFormData() {
//     final authState = ref.read(authProvider);
//     if (authState is Authenticated) {
//       _nameController.text = authState.user.name;
//       _bioController.text = authState.user.bio ?? '';
//       _phoneController.text = authState.user.phone ?? '';
//     }
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _nameController.dispose();
//     _bioController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final authState = ref.watch(authProvider);
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return SlideTransition(
//           position: _slideAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.8, // Adjusted height
//               decoration: BoxDecoration(
//                 color: isDark ? const Color(0xFF1E293B) : Colors.white,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   _buildHeader(theme),
//                   Expanded(
//                     child: _buildForm(theme, authState),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildHeader(ThemeData theme) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: theme.primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.edit_note_outlined,
//               color: theme.primaryColor,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               'Edit Profile',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: const Icon(Icons.close),
//             style: IconButton.styleFrom(
//               backgroundColor: theme.scaffoldBackgroundColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildForm(ThemeData theme, AuthState authState) {
//     if (authState is! Authenticated) {
//       return const Center(child: Text('User not authenticated'));
//     }
//
//     final user = authState.user;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProfileImage(theme, user),
//             const SizedBox(height: 32),
//             _buildTextField(
//               theme: theme,
//               label: 'Full Name',
//               controller: _nameController,
//               hint: 'Enter your full name',
//               icon: Icons.person_outline_rounded,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Email',
//               initialValue: user.email,
//               hint: 'Email address',
//               icon: Icons.email_outlined,
//               enabled: false,
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Bio',
//               controller: _bioController,
//               hint: 'Tell us about yourself...',
//               icon: Icons.info_outline_rounded,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Phone Number',
//               controller: _phoneController,
//               hint: 'Enter your phone number',
//               icon: Icons.phone_outlined,
//               keyboardType: TextInputType.phone,
//             ),
//             const SizedBox(height: 32),
//             _buildSaveButton(theme),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- COMPLETELY REDESIGNED UNIFIED TEXT FIELD BUILDER ---
//   Widget _buildTextField({
//     required ThemeData theme,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextEditingController? controller,
//     String? initialValue,
//     bool enabled = true,
//     int maxLines = 1,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     final isDark = theme.brightness == Brightness.dark;
//     final disabledColor = isDark ? Colors.grey[700] : Colors.grey[300];
//     final disabledTextColor = isDark ? Colors.grey[500] : Colors.grey[600];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: theme.textTheme.titleSmall?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: theme.textTheme.bodySmall?.color,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: enabled ? theme.cardColor : disabledColor,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               )
//             ],
//           ),
//           child: TextFormField(
//             controller: controller,
//             initialValue: initialValue,
//             enabled: enabled,
//             keyboardType: keyboardType,
//             maxLines: maxLines,
//             validator: validator,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: enabled ? theme.textTheme.bodyLarge?.color : disabledTextColor,
//             ),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.5)),
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.only(left: 16, right: 12),
//                 child: Icon(
//                   icon,
//                   color: enabled ? theme.primaryColor : disabledTextColor,
//                 ),
//               ),
//               // Removing all default borders to rely on the container
//               border: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               errorBorder: InputBorder.none,
//               disabledBorder: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(
//                 vertical: 16,
//                 horizontal: maxLines > 1 ? 0 : 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProfileImage(ThemeData theme, User user) {
//     return Center(
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundColor: theme.primaryColor.withOpacity(0.1),
//             backgroundImage: user.profileImage != null
//                 ? NetworkImage(user.profileImage!)
//                 : null,
//             child: user.profileImage == null
//                 ? Icon(
//               Icons.person,
//               size: 50,
//               color: theme.primaryColor,
//             )
//                 : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Image picker coming soon!'),
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSaveButton(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _saveProfile,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: theme.primaryColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 2,
//         ),
//         child: _isLoading
//             ? const SizedBox(
//           height: 20,
//           width: 20,
//           child: CircularProgressIndicator(
//             strokeWidth: 2,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )
//             : const Text(
//           'Save Changes',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final success = await ref.read(authProvider.notifier).updateProfile(
//         name: _nameController.text.trim(),
//         bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
//         phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
//       );
//
//       if (success && mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile updated successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to update profile'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating profile: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
// import '../models/user.dart';
//
// class EditProfileModal extends ConsumerStatefulWidget {
//   const EditProfileModal({super.key});
//
//   @override
//   ConsumerState<EditProfileModal> createState() => _EditProfileModalState();
// }
//
// class _EditProfileModalState extends ConsumerState<EditProfileModal>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _bioController = TextEditingController();
//   final _phoneController = TextEditingController();
//
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _initializeFormData();
//   }
//
//   void _initializeAnimations() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     ));
//
//     _animationController.forward();
//   }
//
//   void _initializeFormData() {
//     final authState = ref.read(authProvider);
//     if (authState is Authenticated) {
//       _nameController.text = authState.user.name;
//       _bioController.text = authState.user.bio ?? '';
//       _phoneController.text = authState.user.phone ?? '';
//     }
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _nameController.dispose();
//     _bioController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final authState = ref.watch(authProvider);
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return SlideTransition(
//           position: _slideAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.8,
//               decoration: BoxDecoration(
//                 color: isDark ? const Color(0xFF1E293B) : Colors.white,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   _buildHeader(theme),
//                   Expanded(
//                     child: _buildForm(theme, authState),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildHeader(ThemeData theme) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: theme.primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.edit_note_outlined,
//               color: theme.primaryColor,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               'Edit Profile',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: const Icon(Icons.close),
//             style: IconButton.styleFrom(
//               backgroundColor: theme.scaffoldBackgroundColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildForm(ThemeData theme, AuthState authState) {
//     if (authState is! Authenticated) {
//       return const Center(child: Text('User not authenticated'));
//     }
//
//     final user = authState.user;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProfileImage(theme, user),
//             const SizedBox(height: 32),
//             _buildTextField(
//               theme: theme,
//               label: 'Full Name',
//               controller: _nameController,
//               hint: 'Enter your full name',
//               icon: Icons.person_outline_rounded,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Email',
//               initialValue: user.email,
//               hint: 'Email address',
//               icon: Icons.email_outlined,
//               enabled: false,
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Bio',
//               controller: _bioController,
//               hint: 'Tell us about yourself...',
//               icon: Icons.info_outline_rounded,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 24),
//             _buildTextField(
//               theme: theme,
//               label: 'Phone Number',
//               controller: _phoneController,
//               hint: 'Enter your phone number',
//               icon: Icons.phone_outlined,
//               keyboardType: TextInputType.phone,
//             ),
//             const SizedBox(height: 32),
//             _buildSaveButton(theme),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- REDESIGNED TEXT FIELD BUILDER TO MATCH ADD TASK MODAL ---
//   Widget _buildTextField({
//     required ThemeData theme,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextEditingController? controller,
//     String? initialValue,
//     bool enabled = true,
//     int maxLines = 1,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     final isDark = theme.brightness == Brightness.dark;
//     final disabledColor = isDark ? Colors.grey[700] : Colors.grey.shade200;
//     final disabledTextColor = isDark ? Colors.grey[500] : Colors.grey[600];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: enabled ? theme.textTheme.bodyLarge?.color : disabledTextColor,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           initialValue: initialValue,
//           enabled: enabled,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           validator: validator,
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: enabled ? theme.textTheme.bodyLarge?.color : disabledTextColor,
//           ),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.5)),
//             prefixIcon: Icon(
//               icon,
//               color: enabled ? theme.textTheme.bodySmall?.color : disabledTextColor,
//             ),
//             filled: true,
//             fillColor: enabled ? theme.cardColor : disabledColor,
//             contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: theme.primaryColor,
//                 width: 2,
//               ),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProfileImage(ThemeData theme, User user) {
//     return Center(
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundColor: theme.primaryColor.withOpacity(0.1),
//             backgroundImage: user.profileImage != null
//                 ? NetworkImage(user.profileImage!)
//                 : null,
//             child: user.profileImage == null
//                 ? Icon(
//               Icons.person,
//               size: 50,
//               color: theme.primaryColor,
//             )
//                 : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Image picker coming soon!'),
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2),
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSaveButton(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _saveProfile,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: theme.primaryColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 2,
//         ),
//         child: _isLoading
//             ? const SizedBox(
//           height: 20,
//           width: 20,
//           child: CircularProgressIndicator(
//             strokeWidth: 2,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )
//             : const Text(
//           'Save Changes',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     try {
//       final success = await ref.read(authProvider.notifier).updateProfile(
//         name: _nameController.text.trim(),
//         bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
//         phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
//       );
//
//       if (success && mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile updated successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to update profile'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating profile: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }
// }





import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';

class EditProfileModal extends ConsumerStatefulWidget {
  const EditProfileModal({super.key});

  @override
  ConsumerState<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends ConsumerState<EditProfileModal>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();

  // State for the new image path
  String? _newProfileImagePath;

  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeFormData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  void _initializeFormData() {
    final authState = ref.read(authProvider);
    if (authState is Authenticated) {
      _nameController.text = authState.user.name;
      _bioController.text = authState.user.bio ?? '';
      _phoneController.text = authState.user.phone ?? '';
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- NEW IMAGE PICKER LOGIC ---
  Future<void> _pickImage(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null && mounted) {
        setState(() {
          _newProfileImagePath = image.path;
        });
      }
    } else if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission to access ${source.name} was denied.')),
      );
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Picture'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authState = ref.watch(authProvider);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(theme),
                  Expanded(
                    child: _buildForm(theme, authState),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.edit_note_outlined,
              color: theme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Edit Profile',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(ThemeData theme, AuthState authState) {
    if (authState is! Authenticated) {
      return const Center(child: Text('User not authenticated'));
    }

    final user = authState.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileImage(theme, user),
            const SizedBox(height: 32),
            _buildTextField(
              theme: theme,
              label: 'Full Name',
              controller: _nameController,
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              theme: theme,
              label: 'Email',
              initialValue: user.email,
              hint: 'Email address',
              icon: Icons.email_outlined,
              enabled: false,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              theme: theme,
              label: 'Bio',
              controller: _bioController,
              hint: 'Tell us about yourself...',
              icon: Icons.info_outline_rounded,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              theme: theme,
              label: 'Phone Number',
              controller: _phoneController,
              hint: 'Enter your phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            _buildSaveButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required ThemeData theme,
    required String label,
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    String? initialValue,
    bool enabled = true,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final disabledColor = isDark ? Colors.grey[700] : Colors.grey.shade200;
    final disabledTextColor = isDark ? Colors.grey[500] : Colors.grey[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: enabled ? theme.textTheme.bodyLarge?.color : disabledTextColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: enabled ? theme.textTheme.bodyLarge?.color : disabledTextColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.5)),
            prefixIcon: Icon(
              icon,
              color: enabled ? theme.textTheme.bodySmall?.color : disabledTextColor,
            ),
            filled: true,
            fillColor: enabled ? theme.cardColor : disabledColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerColor.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(ThemeData theme, User user) {
    // Determine which image to show: new, old, or placeholder
    ImageProvider? backgroundImage;
    if (_newProfileImagePath != null) {
      backgroundImage = FileImage(File(_newProfileImagePath!));
    } else if (user.profileImage != null && user.profileImage!.isNotEmpty) {
      // Assuming old image is a file path for consistency with new images
      backgroundImage = FileImage(File(user.profileImage!));
    }

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            backgroundImage: backgroundImage,
            child: backgroundImage == null
                ? Icon(
              Icons.person,
              size: 50,
              color: theme.primaryColor,
            )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _showImageSourceActionSheet,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final success = await ref.read(authProvider.notifier).updateProfile(
        name: _nameController.text.trim(),
        bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        profileImage: _newProfileImagePath, // Pass the new image path
      );

      if (success && mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}