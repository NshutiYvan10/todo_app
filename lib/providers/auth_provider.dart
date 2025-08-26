import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthNotifier extends StateNotifier<AuthState> {
  late final Box<User> _userBox;
  late final Box<String> _authBox;

  AuthNotifier() : super(AuthInitial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      _userBox = await Hive.openBox<User>('users');
      _authBox = await Hive.openBox<String>('auth');
      _checkAuthStatus();
    } catch (e) {
      state = AuthError('Failed to initialize auth: $e');
    }
  }

  void _checkAuthStatus() {
    final currentUserId = _authBox.get('currentUserId');
    if (currentUserId != null) {
      final user = _userBox.get(currentUserId);
      if (user != null) {
        state = Authenticated(user);
      } else {
        state = Unauthenticated();
      }
    } else {
      state = Unauthenticated();
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      state = AuthLoading();

      // Check if user already exists
      final existingUser = _userBox.values.firstWhere(
            (user) => user.email == email,
        orElse: () => User(
          id: '',
          email: '',
          name: '',
          createdAt: DateTime.now(),
        ),
      );

      if (existingUser.id.isNotEmpty) {
        state = AuthError('User already exists');
        return false;
      }

      // Create new user
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      final user = User(
        id: userId,
        email: email,
        name: name,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      await _userBox.put(userId, user);
      await _authBox.put('currentUserId', userId);

      state = Authenticated(user);
      return true;
    } catch (e) {
      state = AuthError('Sign up failed: $e');
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = AuthLoading();

      // Find user by email
      final user = _userBox.values.firstWhere(
            (user) => user.email == email,
        orElse: () => User(
          id: '',
          email: '',
          name: '',
          createdAt: DateTime.now(),
        ),
      );

      if (user.id.isEmpty) {
        state = AuthError('User not found');
        return false;
      }

      // Update last login
      final updatedUser = user.copyWith(lastLoginAt: DateTime.now());
      await _userBox.put(user.id, updatedUser);
      await _authBox.put('currentUserId', user.id);

      state = Authenticated(updatedUser);
      return true;
    } catch (e) {
      state = AuthError('Sign in failed: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authBox.delete('currentUserId');
      state = Unauthenticated();
    } catch (e) {
      state = AuthError('Sign out failed: $e');
    }
  }

  Future<bool> updateProfile({
    required String name,
    String? bio,
    String? phone,
    String? profileImage,
  }) async {
    try {
      if (state is! Authenticated) return false;

      final currentUser = (state as Authenticated).user;
      final updatedUser = currentUser.copyWith(
        name: name,
        bio: bio,
        phone: phone,
        profileImage: profileImage,
      );

      await _userBox.put(currentUser.id, updatedUser);
      state = Authenticated(updatedUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  String? getCurrentUserId() {
    if (state is Authenticated) {
      return (state as Authenticated).user.id;
    }
    return null;
  }

  User? getCurrentUser() {
    if (state is Authenticated) {
      return (state as Authenticated).user;
    }
    return null;
  }
}
