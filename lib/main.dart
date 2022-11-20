import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/counter_screen.dart';
import 'package:udemy/layout/news_app/news_layout.dart';
import 'package:udemy/layout/todo_app/todo_layout.dart';
import 'package:udemy/modules/bmi/bmi_screen.dart';
import 'package:udemy/modules/counter/counter_screen.dart';
import 'package:udemy/modules/login/login_screen.dart';
import 'package:udemy/modules/messenger/messenger_screen.dart';
import 'package:udemy/modules/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:udemy/shared/bloc_observer.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.black)),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
      ),
      darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black),
      themeMode: ThemeMode.light,
      home: const NewsLayout(),
    );
  }
}
