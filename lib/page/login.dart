// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            buildlogSection(),
          ],
        ),
      ),
    );
  }
}

Widget buildlogSection() {
  return Center(
    child: Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 100),
              child: Text(
                'FoodNutri',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            Container(
              width: 320,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            ButtonTheme(
              minWidth: 300,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.black,
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
                      child: InkWell(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
