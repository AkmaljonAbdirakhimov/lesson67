import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  

  static Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // print("Firebase Error: $e");
    } catch (e) {
      // print("Catch Error: $e");
    }
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // print("Firebase Error: $e");
    } catch (e) {
      // print("Catch Error: $e");
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
