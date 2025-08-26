// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/auth_provider.dart';
// import '../auth/login_screen.dart';
//
// class OnboardingScreen extends ConsumerStatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
//     with TickerProviderStateMixin {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   late AnimationController _avatarAnimationController;
//   late Animation<double> _avatarScaleAnimation;
//   late Animation<double> _avatarRotationAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _avatarAnimationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//
//     _avatarScaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.2,
//     ).animate(CurvedAnimation(
//       parent: _avatarAnimationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _avatarRotationAnimation = Tween<double>(
//       begin: 0,
//       end: 0.1,
//     ).animate(CurvedAnimation(
//       parent: _avatarAnimationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _avatarAnimationController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _avatarAnimationController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   final List<OnboardingPage> _pages = [
//     OnboardingPage(
//       title: 'Organize Your Tasks',
//       description: 'Keep track of all your tasks in one beautiful, intuitive interface designed for productivity.',
//       icon: Icons.task_alt,
//       color: const Color(0xFF6366F1),
//       illustration: _buildTaskIllustration(),
//     ),
//     OnboardingPage(
//       title: 'Set Priorities',
//       description: 'Organize tasks by priority levels and never miss what\'s important to you.',
//       icon: Icons.priority_high,
//       color: const Color(0xFF8B5CF6),
//       illustration: _buildPriorityIllustration(),
//     ),
//     OnboardingPage(
//       title: 'Track Progress',
//       description: 'Visualize your productivity with beautiful charts and motivational insights.',
//       icon: Icons.analytics,
//       color: const Color(0xFF06B6D4),
//       illustration: _buildAnalyticsIllustration(),
//     ),
//     OnboardingPage(
//       title: 'Stay Motivated',
//       description: 'Get daily inspiration with motivational quotes and achievement celebrations.',
//       icon: Icons.emoji_events,
//       color: const Color(0xFFEC4899),
//       illustration: _buildMotivationIllustration(),
//     ),
//   ];
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
//               _pages[_currentPage].color,
//               _pages[_currentPage].color.withOpacity(0.7),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Skip button
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: TextButton(
//                     onPressed: _completeOnboarding,
//                     child: const Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Page view
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentPage = index;
//                     });
//                   },
//                   itemCount: _pages.length,
//                   itemBuilder: (context, index) {
//                     return _buildPage(_pages[index]);
//                   },
//                 ),
//               ),
//
//               // Page indicators
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   _pages.length,
//                       (index) => AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     width: _currentPage == index ? 24 : 8,
//                     height: 8,
//                     decoration: BoxDecoration(
//                       color: _currentPage == index
//                           ? Colors.white
//                           : Colors.white.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 40),
//
//               // Navigation buttons
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     if (_currentPage > 0)
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             _pageController.previousPage(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             );
//                           },
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(color: Colors.white, width: 2),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: const Text('Previous'),
//                         ),
//                       ),
//                     if (_currentPage > 0) const SizedBox(width: 16),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_currentPage == _pages.length - 1) {
//                             _completeOnboarding();
//                           } else {
//                             _pageController.nextPage(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: _pages[_currentPage].color,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                         ),
//                         child: Text(
//                           _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPage(OnboardingPage page) {
//     return Padding(
//       padding: const EdgeInsets.all(40),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Animated illustration
//           AnimatedBuilder(
//             animation: _avatarAnimationController,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _avatarScaleAnimation.value,
//                 child: Transform.rotate(
//                   angle: _avatarRotationAnimation.value,
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: page.illustration,
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 60),
//           Text(
//             page.title,
//             style: const TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             page.description,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Colors.white70,
//               height: 1.5,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _completeOnboarding() {
//     ref.read(authProvider.notifier).completeOnboarding();
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           );
//         },
//         transitionDuration: const Duration(milliseconds: 500),
//       ),
//     );
//   }
//
//   static Widget _buildTaskIllustration() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Background circles
//         Positioned(
//           top: 20,
//           left: 20,
//           child: Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 30,
//           right: 30,
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//         ),
//         // Main task icon
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.task_alt,
//             size: 50,
//             color: Color(0xFF6366F1),
//           ),
//         ),
//         // Floating checkmarks
//         const Positioned(
//           top: 60,
//           right: 40,
//           child: Icon(
//             Icons.check_circle,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         const Positioned(
//           bottom: 60,
//           left: 40,
//           child: Icon(
//             Icons.check_circle,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//       ],
//     );
//   }
//
//   static Widget _buildPriorityIllustration() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Priority bars
//         Positioned(
//           left: 30,
//           child: Column(
//             children: [
//               Container(width: 40, height: 60, color: Colors.red.withOpacity(0.8)),
//               const SizedBox(height: 4),
//               Container(width: 40, height: 40, color: Colors.orange.withOpacity(0.8)),
//               const SizedBox(height: 4),
//               Container(width: 40, height: 20, color: Colors.green.withOpacity(0.8)),
//             ],
//           ),
//         ),
//         // Main priority icon
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.priority_high,
//             size: 50,
//             color: Color(0xFF8B5CF6),
//           ),
//         ),
//         // Floating priority indicators
//         const Positioned(
//           top: 40,
//           right: 20,
//           child: Icon(
//             Icons.star,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//         const Positioned(
//           bottom: 40,
//           right: 30,
//           child: Icon(
//             Icons.flag,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//       ],
//     );
//   }
//
//   static Widget _buildAnalyticsIllustration() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Chart bars
//         Positioned(
//           bottom: 40,
//           child: Row(
//             children: [
//               Container(width: 12, height: 40, color: Colors.white.withOpacity(0.8)),
//               const SizedBox(width: 4),
//               Container(width: 12, height: 60, color: Colors.white.withOpacity(0.6)),
//               const SizedBox(width: 4),
//               Container(width: 12, height: 30, color: Colors.white.withOpacity(0.8)),
//               const SizedBox(width: 4),
//               Container(width: 12, height: 50, color: Colors.white.withOpacity(0.7)),
//             ],
//           ),
//         ),
//         // Main analytics icon
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.analytics,
//             size: 50,
//             color: Color(0xFF06B6D4),
//           ),
//         ),
//         // Floating trend arrow
//         const Positioned(
//           top: 30,
//           right: 30,
//           child: Icon(
//             Icons.trending_up,
//             color: Colors.white,
//             size: 28,
//           ),
//         ),
//       ],
//     );
//   }
//
//   static Widget _buildMotivationIllustration() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Celebration particles
//         const Positioned(
//           top: 20,
//           left: 40,
//           child: Icon(Icons.star, color: Colors.white, size: 16),
//         ),
//         const Positioned(
//           top: 40,
//           right: 30,
//           child: Icon(Icons.star, color: Colors.white, size: 12),
//         ),
//         const Positioned(
//           bottom: 30,
//           left: 30,
//           child: Icon(Icons.star, color: Colors.white, size: 14),
//         ),
//         const Positioned(
//           bottom: 50,
//           right: 40,
//           child: Icon(Icons.star, color: Colors.white, size: 18),
//         ),
//         // Main trophy icon
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.emoji_events,
//             size: 50,
//             color: Color(0xFFEC4899),
//           ),
//         ),
//         // Floating celebration icons
//         const Positioned(
//           top: 60,
//           left: 20,
//           child: Icon(
//             Icons.celebration,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class OnboardingPage {
//   final String title;
//   final String description;
//   final IconData icon;
//   final Color color;
//   final Widget illustration;
//
//   OnboardingPage({
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.color,
//     required this.illustration,
//   });
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _avatarAnimationController;
  late Animation<double> _avatarScaleAnimation;
  late Animation<double> _avatarRotationAnimation;

  @override
  void initState() {
    super.initState();

    _avatarAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _avatarScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _avatarAnimationController,
      curve: Curves.easeInOut,
    ));

    _avatarRotationAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _avatarAnimationController,
      curve: Curves.easeInOut,
    ));

    _avatarAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _avatarAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Organize Your Tasks',
      description:
      'Keep track of all your tasks in one beautiful, intuitive interface designed for productivity.',
      icon: Icons.task_alt,
      color: const Color(0xFF6366F1),
      illustration: _buildTaskIllustration(),
    ),
    OnboardingPage(
      title: 'Set Priorities',
      description:
      'Organize tasks by priority levels and never miss what\'s important to you.',
      icon: Icons.priority_high,
      color: const Color(0xFF8B5CF6),
      illustration: _buildPriorityIllustration(),
    ),
    OnboardingPage(
      title: 'Track Progress',
      description:
      'Visualize your productivity with beautiful charts and motivational insights.',
      icon: Icons.analytics,
      color: const Color(0xFF06B6D4),
      illustration: _buildAnalyticsIllustration(),
    ),
    OnboardingPage(
      title: 'Stay Motivated',
      description:
      'Get daily inspiration with motivational quotes and achievement celebrations.',
      icon: Icons.emoji_events,
      color: const Color(0xFFEC4899),
      illustration: _buildMotivationIllustration(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _pages[_currentPage].color,
              _pages[_currentPage].color.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Colors.white, width: 2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _pages[_currentPage].color,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated illustration
          AnimatedBuilder(
            animation: _avatarAnimationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _avatarScaleAnimation.value,
                child: Transform.rotate(
                  angle: _avatarRotationAnimation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: page.illustration,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 60),
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    ref.read(authProvider.notifier).completeOnboarding();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  static Widget _buildTaskIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circles
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Main task icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.task_alt,
            size: 50,
            color: Color(0xFF6366F1),
          ),
        ),
        // Floating checkmarks
        const Positioned(
          top: 60,
          right: 40,
          child: Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 24,
          ),
        ),
        const Positioned(
          bottom: 60,
          left: 40,
          child: Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  static Widget _buildPriorityIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Priority bars
        Positioned(
          left: 30,
          child: Column(
            children: [
              Container(
                  width: 40, height: 60, color: Colors.red.withOpacity(0.8)),
              const SizedBox(height: 4),
              Container(
                  width: 40,
                  height: 40,
                  color: Colors.orange.withOpacity(0.8)),
              const SizedBox(height: 4),
              Container(
                  width: 40, height: 20, color: Colors.green.withOpacity(0.8)),
            ],
          ),
        ),
        // Main priority icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.priority_high,
            size: 50,
            color: Color(0xFF8B5CF6),
          ),
        ),
        // Floating priority indicators
        const Positioned(
          top: 40,
          right: 20,
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: 24,
          ),
        ),
        const Positioned(
          bottom: 40,
          right: 30,
          child: Icon(
            Icons.flag,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  static Widget _buildAnalyticsIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Chart bars
        Positioned(
          bottom: 40,
          child: Row(
            children: [
              Container(
                  width: 12, height: 40, color: Colors.white.withOpacity(0.8)),
              const SizedBox(width: 4),
              Container(
                  width: 12, height: 60, color: Colors.white.withOpacity(0.6)),
              const SizedBox(width: 4),
              Container(
                  width: 12, height: 30, color: Colors.white.withOpacity(0.8)),
              const SizedBox(width: 4),
              Container(
                  width: 12, height: 50, color: Colors.white.withOpacity(0.7)),
            ],
          ),
        ),
        // Main analytics icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.analytics,
            size: 50,
            color: Color(0xFF06B6D4),
          ),
        ),
        // Floating trend arrow
        const Positioned(
          top: 30,
          right: 30,
          child: Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }

  static Widget _buildMotivationIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Celebration particles
        const Positioned(
          top: 20,
          left: 40,
          child: Icon(Icons.star, color: Colors.white, size: 16),
        ),
        const Positioned(
          top: 40,
          right: 30,
          child: Icon(Icons.star, color: Colors.white, size: 12),
        ),
        const Positioned(
          bottom: 30,
          left: 30,
          child: Icon(Icons.star, color: Colors.white, size: 14),
        ),
        const Positioned(
          bottom: 50,
          right: 40,
          child: Icon(Icons.star, color: Colors.white, size: 18),
        ),
        // Main trophy icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.emoji_events,
            size: 50,
            color: Color(0xFFEC4899),
          ),
        ),
        // Floating celebration icons
        const Positioned(
          top: 60,
          left: 20,
          child: Icon(
            Icons.celebration,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget illustration;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.illustration,
  });
}