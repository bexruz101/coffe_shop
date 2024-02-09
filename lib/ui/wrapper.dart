import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/ui/auth/auth_screen.dart';
import 'package:flutter_application_1/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFirebase?>(context);

    if (user == null) {
      return AuthScreen();
    } else {
      return HomeScreen();
    }
  }
}
