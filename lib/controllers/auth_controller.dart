import 'package:flutter/material.dart';
import 'package:lesson67/services/firebase_auth_service.dart';

class AuthController with ChangeNotifier {
  Future<void> login(String email, String password) async {
    await FirebaseAuthService.login(email: email, password: password);
  }

  Future<void> register(String email, String password) async {
    await FirebaseAuthService.register(email: email, password: password);
    notifyListeners();
  }
}
