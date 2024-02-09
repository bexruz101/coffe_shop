import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/register.dart';
import 'package:flutter_application_1/ui/auth/sign_in.dart';

class AuthScreen extends StatefulWidget {
  @override
  createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return Register(
        toggleView: toggleView,
      );
    }
  }
}
