// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'today_screen.dart';
// import 'tasks_screen.dart';
// import 'calendar_screen.dart';
// import 'profile_screen.dart';
// import '../widgets/add_task_modal.dart';
//
// class MainScreen extends ConsumerStatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   ConsumerState<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends ConsumerState<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const TodayScreen(),
//     const TasksScreen(),
//     const CalendarScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       floatingActionButton: Container(
//         margin: const EdgeInsets.only(bottom: 80),
//         child: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) => const AddTaskModal(),
//                 transitionDuration: const Duration(milliseconds: 300),
//                 reverseTransitionDuration: const Duration(milliseconds: 300),
//                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   );
//                 },
//                 opaque: false,
//               ),
//             );
//           },
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           child: const Icon(
//             Icons.add,
//             color: Colors.white,
//             size: 28,
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary,
//               Theme.of(context).colorScheme.secondary,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.white.withOpacity(0.6),
//             selectedFontSize: 12,
//             unselectedFontSize: 12,
//             items: [
//               _buildNavItem(Icons.today_outlined, Icons.today, 'Today', 0),
//               _buildNavItem(Icons.task_outlined, Icons.task, 'Tasks', 1),
//               _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today, 'Calendar', 2),
//               _buildNavItem(Icons.person_outline, Icons.person, 'Profile', 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem(
//       IconData outlinedIcon,
//       IconData filledIcon,
//       String label,
//       int index,
//       ) {
//     final isSelected = _currentIndex == index;
//     return BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Colors.white.withOpacity(0.2)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           isSelected ? filledIcon : outlinedIcon,
//           size: 24,
//         ),
//       ),
//       label: label,
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/task_provider.dart';
// import 'today_screen.dart';
// import 'tasks_screen.dart';
// import 'calendar_screen.dart';
// import 'profile_screen.dart';
// import '../widgets/add_task_modal.dart';
//
// class MainScreen extends ConsumerStatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   ConsumerState<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends ConsumerState<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const TodayScreen(),
//     const TasksScreen(),
//     const CalendarScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       floatingActionButton: Container(
//         margin: const EdgeInsets.only(bottom: 80),
//         child: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     AddTaskModal(
//                       onTaskSaved: (task) {
//                         if (task.id.isEmpty) {
//                           ref.read(taskProvider.notifier).addTask(task);
//                         } else {
//                           ref.read(taskProvider.notifier).updateTask(task);
//                         }
//                       },
//                     ),
//                 transitionDuration: const Duration(milliseconds: 300),
//                 reverseTransitionDuration: const Duration(milliseconds: 300),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   );
//                 },
//                 opaque: false,
//               ),
//             );
//           },
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           child: const Icon(
//             Icons.add,
//             color: Colors.white,
//             size: 28,
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary,
//               Theme.of(context).colorScheme.secondary,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.white.withOpacity(0.6),
//             selectedFontSize: 12,
//             unselectedFontSize: 12,
//             items: [
//               _buildNavItem(Icons.today_outlined, Icons.today, 'Today', 0),
//               _buildNavItem(Icons.task_outlined, Icons.task, 'Tasks', 1),
//               _buildNavItem(Icons.calendar_today_outlined,
//                   Icons.calendar_today, 'Calendar', 2),
//               _buildNavItem(
//                   Icons.person_outline, Icons.person, 'Profile', 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem(
//       IconData outlinedIcon,
//       IconData filledIcon,
//       String label,
//       int index,
//       ) {
//     final isSelected = _currentIndex == index;
//     return BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color:
//           isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           isSelected ? filledIcon : outlinedIcon,
//           size: 24,
//         ),
//       ),
//       label: label,
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'today_screen.dart';
import 'tasks_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';
import '../widgets/add_task_modal.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TodayScreen(),
    const TasksScreen(),
    const CalendarScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddTaskModal(
              onTaskSaved: (task) {
                // A simple check to see if it's a new task or an existing one
                if (ref.read(taskProvider).any((t) => t.id == task.id)) {
                  ref.read(taskProvider.notifier).updateTask(task);
                } else {
                  ref.read(taskProvider.notifier).addTask(task);
                }
              },
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        elevation: 4.0,
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        // The BottomAppBar acts as a transparent placeholder for spacing.
        // We give it a total height to contain our pill and create space around it.
        height: 95,
        child: Container(
          height: 75,
          // We only need horizontal margin now.
          margin: const EdgeInsets.symmetric(horizontal: 24),
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildNavItem(
                icon: Icons.wb_sunny_outlined,
                label: 'Today',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.checklist_rtl_outlined,
                label: 'Tasks',
                index: 1,
              ),
              const SizedBox(width: 40), // The gap for the FloatingActionButton
              _buildNavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Calendar',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    // Using a simple Padding and Column which is less likely to overflow
    return Expanded(
      child: InkWell(
        onTap: () => _onTabTapped(index),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}