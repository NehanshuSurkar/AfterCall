import 'dart:convert';
import 'package:after_call/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  AuthService() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      if (userJson != null) {
        _currentUser = User.fromJson(jsonDecode(userJson));
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load auth state: $e');
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: email.split('@')[0],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return _saveUser(user);
  }

  Future<bool> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: 'demo@aftercall.com',
      name: 'Demo User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return _saveUser(user);
  }

  Future<bool> _saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', jsonEncode(user.toJson()));
      _currentUser = user;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Failed to save user: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
      _currentUser = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to sign out: $e');
    }
  }

  bool shouldShowOnboarding() {
    return !_isAuthenticated;
  }
}

// In your auth_service.dart file
Future<bool> registerWithEmail(
  String email,
  String password,
  String name,
) async {
  try {
    // Your registration logic here
    // Example with Firebase Auth:
    /*
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Update user profile with name
    await userCredential.user?.updateDisplayName(name);
    
    // Reload user to get updated info
    await userCredential.user?.reload();
    
    // Update your local user state
    _currentUser = User(
      id: userCredential.user?.uid ?? '',
      email: email,
      name: name,
    );
    notifyListeners();
    */

    // Simulate success for now
    await Future.delayed(const Duration(seconds: 1));
    return true;
  } catch (e) {
    debugPrint('Registration failed: $e');
    return false;
  }
}
