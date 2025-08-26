import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task.dart';
import 'models/user.dart';
import 'models/priority.dart';
import 'models/category.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'themes/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());
  Hive.registerAdapter(TaskCategoryAdapter());

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Flutter Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: _getHomeScreen(authState),
    );
  }

  Widget _getHomeScreen(AuthState authState) {
    switch (authState.runtimeType) {
      case AuthInitial:
        return const SplashScreen();
      case AuthLoading:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case Authenticated:
        return const MainScreen();
      case Unauthenticated:
        return const LoginScreen();
      case AuthError:
        return const LoginScreen();
      default:
        return const SplashScreen();
    }
  }
}
