import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/admin/admin_view.dart';
import 'package:mehmetcanmovies/login/login_view.dart';
import 'package:mehmetcanmovies/main/main_view.dart';
import 'package:mehmetcanmovies/sign_up/sign_up_view.dart';

mixin LoginViewMixin on State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late UserCredential userCredential;

  Future<void> login(BuildContext context) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      switch (userCredential.user?.emailVerified) {
        case true:
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainView()),
          );
          break;
        case false:
          if (userCredential.user?.email == "admin@admin.com") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainView()),
            );
            break;
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text(
                    'Please verify your email address before login.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
          break;
        default:
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text(
                    'Failed to login. Please enter the correct email and password.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Oops'),
            content: const Text(
                'Failed to login. Please enter the correct email and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void signUp(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpView()));
  }
}
