import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson67/utils/messages.dart';
import 'package:lesson67/utils/routes.dart';

import '../widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submit() {
    if (formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.abc,
                size: 150,
                color: Colors.blue,
              ),
              Text(
                "TIZIMGA KIRISH",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: emailController,
                label: "Elektron pochta",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos pochta kiriting";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                label: "Parol",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos parol kiriting";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submit,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("K I R I S H"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: const Text("Ro'yxatdan O'tish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
