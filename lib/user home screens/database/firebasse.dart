import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<bool> isTokenValid() async {
    final currentUser = await _auth.currentUser;
    if (currentUser != null) {
      try {
        // Check if the token is still valid by refreshing the user
        await currentUser.reload();
        return true;
      } catch (e) {
        // Handle any errors
        print("Error refreshing user: $e");
        return false;
      }
    }
    return false;
  }

  Future<void> signIn() async {
    try {
      // Sign in user
      // Example: await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Sign-in error: $e");
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out user
      await _auth.signOut();
    } catch (e) {
      print("Sign-out error: $e");
    }
  }
}
