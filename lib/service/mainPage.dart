import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../page/main_page.dart';
import 'signin_page.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Something went wrong...!'),
            );
          } else if (snapshot.hasData ) {
            return Homepage();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}