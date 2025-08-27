// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/auth_provider.dart';
// import '../main_screen.dart';
// import 'signup_screen.dart';
// import 'forgot_password_screen.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//
//   late AnimationController _animationController;
//   late AnimationController _logoAnimationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoRotationAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );
//
//     _logoAnimationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//     ));
//
//     _logoScaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.1,
//     ).animate(CurvedAnimation(
//       parent: _logoAnimationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _logoRotationAnimation = Tween<double>(
//       begin: 0,
//       end: 0.05,
//     ).animate(CurvedAnimation(
//       parent: _logoAnimationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _animationController.forward();
//     _logoAnimationController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _logoAnimationController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary,
//               Theme.of(context).colorScheme.secondary,
//               Theme.of(context).colorScheme.tertiary,
//             ],
//             stops: const [0.0, 0.5, 1.0],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height -
//                   MediaQuery.of(context).padding.top,
//               child: AnimatedBuilder(
//                 animation: _animationController,
//                 builder: (context, child) {
//                   return FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: SlideTransition(
//                       position: _slideAnimation,
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           children: [
//                             const Spacer(),
//
//                             // Animated Logo
//                             AnimatedBuilder(
//                               animation: _logoAnimationController,
//                               builder: (context, child) {
//                                 return Transform.scale(
//                                   scale: _logoScaleAnimation.value,
//                                   child: Transform.rotate(
//                                     angle: _logoRotationAnimation.value,
//                                     child: Container(
//                                       width: 120,
//                                       height: 120,
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                           colors: [
//                                             Colors.white,
//                                             Colors.white.withOpacity(0.9),
//                                           ],
//                                         ),
//                                         borderRadius: BorderRadius.circular(30),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withOpacity(0.2),
//                                             blurRadius: 30,
//                                             offset: const Offset(0, 15),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           // Background pattern
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(30),
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.topLeft,
//                                                 end: Alignment.bottomRight,
//                                                 colors: [
//                                                   Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                                                   Theme.of(context).colorScheme.secondary.withOpacity(0.1),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           // Main icon
//                                           Container(
//                                             padding: const EdgeInsets.all(20),
//                                             decoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.topLeft,
//                                                 end: Alignment.bottomRight,
//                                                 colors: [
//                                                   Theme.of(context).colorScheme.primary,
//                                                   Theme.of(context).colorScheme.secondary,
//                                                 ],
//                                               ),
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: const Icon(
//                                               Icons.task_alt,
//                                               size: 40,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//
//                             const SizedBox(height: 32),
//
//                             // App title and subtitle
//                             Column(
//                               children: [
//                                 ShaderMask(
//                                   shaderCallback: (bounds) => LinearGradient(
//                                     colors: [
//                                       Colors.white,
//                                       Colors.white.withOpacity(0.8),
//                                     ],
//                                   ).createShader(bounds),
//                                   child: const Text(
//                                     'TaskFlow Pro',
//                                     style: TextStyle(
//                                       fontSize: 36,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'Welcome back! Sign in to continue your productivity journey',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white.withOpacity(0.8),
//                                     height: 1.4,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 48),
//
//                             // Login form
//                             Container(
//                               padding: const EdgeInsets.all(32),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.95),
//                                 borderRadius: BorderRadius.circular(32),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 30,
//                                     offset: const Offset(0, 15),
//                                   ),
//                                 ],
//                                 border: Border.all(
//                                   color: Colors.white.withOpacity(0.2),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Column(
//                                   children: [
//                                     // Email field
//                                     _buildCustomTextField(
//                                       controller: _emailController,
//                                       label: 'Email Address',
//                                       hint: 'Enter your email',
//                                       icon: Icons.email_outlined,
//                                       keyboardType: TextInputType.emailAddress,
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter your email';
//                                         }
//                                         if (!value.contains('@')) {
//                                           return 'Please enter a valid email';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//
//                                     const SizedBox(height: 24),
//
//                                     // Password field
//                                     _buildCustomTextField(
//                                       controller: _passwordController,
//                                       label: 'Password',
//                                       hint: 'Enter your password',
//                                       icon: Icons.lock_outlined,
//                                       obscureText: _obscurePassword,
//                                       suffixIcon: IconButton(
//                                         icon: Icon(
//                                           _obscurePassword
//                                               ? Icons.visibility_outlined
//                                               : Icons.visibility_off_outlined,
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _obscurePassword = !_obscurePassword;
//                                           });
//                                         },
//                                       ),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter your password';
//                                         }
//                                         if (value.length < 6) {
//                                           return 'Password must be at least 6 characters';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Forgot password
//                                     Align(
//                                       alignment: Alignment.centerRight,
//                                       child: TextButton(
//                                         onPressed: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => const ForgotPasswordScreen(),
//                                             ),
//                                           );
//                                         },
//                                         child: Text(
//                                           'Forgot Password?',
//                                           style: TextStyle(
//                                             color: Theme.of(context).colorScheme.primary,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 32),
//
//                                     // Sign in button
//                                     SizedBox(
//                                       width: double.infinity,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                             colors: [
//                                               Theme.of(context).colorScheme.primary,
//                                               Theme.of(context).colorScheme.secondary,
//                                             ],
//                                           ),
//                                           borderRadius: BorderRadius.circular(20),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
//                                               blurRadius: 15,
//                                               offset: const Offset(0, 8),
//                                             ),
//                                           ],
//                                         ),
//                                         child: ElevatedButton(
//                                           onPressed: _isLoading ? null : _signIn,
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.transparent,
//                                             shadowColor: Colors.transparent,
//                                             padding: const EdgeInsets.symmetric(vertical: 18),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                           ),
//                                           child: _isLoading
//                                               ? const SizedBox(
//                                             height: 24,
//                                             width: 24,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               valueColor: AlwaysStoppedAnimation<Color>(
//                                                 Colors.white,
//                                               ),
//                                             ),
//                                           )
//                                               : const Text(
//                                             'Sign In',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             const Spacer(),
//
//                             // Sign up link
//                             Container(
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.white.withOpacity(0.2),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Don\'t have an account? ',
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.8),
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => const SignupScreen(),
//                                         ),
//                                       );
//                                     },
//                                     child: const Text(
//                                       'Sign Up',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(height: 24),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCustomTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextInputType? keyboardType,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey.shade700,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.grey.shade50,
//                 Colors.white,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: Colors.grey.shade200,
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             obscureText: obscureText,
//             validator: validator,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//             decoration: InputDecoration(
//               hintText: hint,
//               prefixIcon: Container(
//                 margin: const EdgeInsets.all(12),
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                       Theme.of(context).colorScheme.secondary.withOpacity(0.2),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, size: 20),
//               ),
//               suffixIcon: suffixIcon,
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.all(20),
//               hintStyle: TextStyle(
//                 color: Colors.grey.shade500,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _signIn() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final success = await ref.read(authProvider.notifier).signIn(
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//     );
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (success) {
//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const MainScreen()),
//         );
//       }
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Invalid email or password'),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//       }
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../main_screen.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _animationController;
  late AnimationController _logoAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoRotationAnimation = Tween<double>(
      begin: 0,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _logoAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _logoAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // The fixed-height SizedBox was removed from here
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                        children: [
                          const SizedBox(height: 40), // Added some top padding

                          // Animated Logo
                          AnimatedBuilder(
                            animation: _logoAnimationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _logoScaleAnimation.value,
                                child: Transform.rotate(
                                  angle: _logoRotationAnimation.value,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0.9),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 30,
                                          offset: const Offset(0, 15),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Background pattern
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.1),
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.1),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Main icon
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: const Icon(
                                            Icons.task_alt,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),

                          // App title and subtitle
                          Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.8),
                                  ],
                                ).createShader(bounds),
                                child: const Text(
                                  'TaskFlow Pro',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Welcome back! Sign in to continue your productivity journey',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.8),
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),

                          const SizedBox(height: 48),

                          // Login form
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Email field
                                  _buildCustomTextField(
                                    controller: _emailController,
                                    label: 'Email Address',
                                    hint: 'Enter your email',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 24),

                                  // Password field
                                  _buildCustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    hint: 'Enter your password',
                                    icon: Icons.lock_outlined,
                                    obscureText: _obscurePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword =
                                          !_obscurePassword;
                                        });
                                      },
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  // Forgot password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const ForgotPasswordScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 32),

                                  // Sign in button
                                  SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.4),
                                            blurRadius: 15,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed:
                                        _isLoading ? null : _signIn,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child:
                                          CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                            AlwaysStoppedAnimation<
                                                Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                            : const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40), // Added some bottom padding

                          // Sign up link
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade50,
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20),
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final success = await ref.read(authProvider.notifier).signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid email or password'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }
}