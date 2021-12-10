import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:tyba_test/src/User/models/user_model.dart';

class UserRepository {
  final fb.FirebaseAuth _firebaseAuth;

  UserRepository({fb.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;

  Future<User?> register(User user, String password) async {
    try {
      final fb.UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(user.name);
      }
      return User(
        name: credential.user!.displayName!,
        email: credential.user!.email!,
      );
    } catch (e) {
      log("User register failed: $e");
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        return User(
          name: credentials.user!.displayName!,
          email: credentials.user!.email!,
        );
      }
      return null;
    } catch (e) {
      log("User login failed: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log("User logout failed: $e");
      rethrow;
    }
  }

  User? getCurrentUser() {
    final fb.User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return User(
        name: user.displayName!,
        email: user.email!,
      );
    }
    return null;
  }

  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((fb.User? user) {
      if (user == null) {
        return null;
      }
      return User(
        name: user.displayName ?? 'NA',
        email: user.email!,
      );
    });
  }
}
