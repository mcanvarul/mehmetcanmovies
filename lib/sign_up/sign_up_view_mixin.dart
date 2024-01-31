import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/login/login_view.dart';
import 'package:mehmetcanmovies/sign_up/sign_up_view.dart';

mixin SignUpViewMixin on State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Form key
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required.';
    }
    // E-posta adresi doğrulama kontrolü
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    // Parola uzunluğu kontrolü
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    }
    // Kullanıcı adı uzunluğu kontrolü
    if (value.length < 4 || value.length > 8) {
      return 'Username must be between 4 and 8 characters.';
    }
    return null;
  }

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();

        User? user = userCredential.user;

        if (user != null) {
          await user.updateDisplayName(userNameController.text);

          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Oops'),
                content: const Text(
                    'Your account has been created. Please verify your email address'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print("************************");
        print(e);
      }
    }
  }
}
