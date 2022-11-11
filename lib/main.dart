import 'package:bmi_a/modules/bmi/bmi_screen.dart';
import 'package:bmi_a/modules/login/login_screen.dart';
import 'package:bmi_a/modules/messenger/messenger_screen.dart';
import 'package:bmi_a/modules/users/users_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
