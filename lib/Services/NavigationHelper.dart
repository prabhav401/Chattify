import 'package:dbms_project/Views/signin.dart';
import 'package:dbms_project/Views/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
      if (showSignIn) {
        return SignIn(toggleView);
      } else {
        return SignUp(toggleView);
      }
  }
}
