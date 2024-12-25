import 'package:firebase_auth/firebase_auth.dart';

class LoginAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Login successful! Welcome ${userCredential.user!.email}';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      } else {
        return e.message ?? 'Login failed.';
      }
    } catch (e) {
      return 'An error occurred: ${e.toString()}';
    }
  }
}