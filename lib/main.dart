import 'package:bloc/bloc.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/counter_screen.dart';
import 'package:udemy/layout/home_layout.dart';
import 'package:udemy/modules/bmi/bmi_screen.dart';
import 'package:udemy/modules/counter/counter_screen.dart';
import 'package:udemy/modules/login/login_screen.dart';
import 'package:udemy/modules/messenger/messenger_screen.dart';
import 'package:udemy/modules/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:udemy/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreenE(),
    );
  }
}
