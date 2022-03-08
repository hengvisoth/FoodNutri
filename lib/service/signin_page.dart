import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';


import '../page/home.dart';
import 'google_signin_service.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    email.addListener(onListen);
    password.addListener(onListen);
  }

  @override
  void dispose() {
    super.dispose();
    email.removeListener(onListen);
    password.removeListener(onListen);
  }

  void onListen() => setState(() {});
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: EdgeInsets.all(20),

                    child: const Text(
                  "FoodNutri",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: email.text.isEmpty
                        ? const SizedBox(width: 0.0)
                        : IconButton(
                            onPressed: () => email.clear(),
                            icon: const Icon(Icons.close),
                          ),
                  ),
                  autofillHints: const [AutofillHints.email],
                  validator: (value) {
                    return value != null && !EmailValidator.validate(value)
                        ? 'Please enter a valid email'
                        : null;
                  },
                ),
                const SizedBox(height: 26.0),
                TextFormField(
                  obscureText: isPassword,
                  controller: password,
                  style: const TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: password.text.isEmpty
                        ? const SizedBox(width: 0.0)
                        : IconButton(
                            onPressed: () {
                              if (isPassword) {
                                setState(() => isPassword = false);
                              } else {
                                setState(() => isPassword = true);
                              }
                            },
                            icon: Icon(isPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                  ),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Password is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 26.0),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 9, 128, 13))),
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      signin();
                    }
                  },
                  child: const Text('          LOGIN          '),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text('Create'),
                    )
                  ],
                ),
                Center(
                  child: FloatingActionButton.extended(
                    backgroundColor: Color.fromARGB(255, 9, 128, 14), 
                   
                    icon: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Google_2011_logo.png/640px-Google_2011_logo.png")),
                    onPressed: () {
                      GoogleSigninService().siginWithGoogle();
                      setState(() {});
                    },
                    label: Text("Login with Google",
                        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      ).then((value) => Get.to(Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('No user found for that email.')),
          );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(' Wrong password provided for that user.'),
            ),
          );
      }
    }
  }

  Future<void> showLoading() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }
}
