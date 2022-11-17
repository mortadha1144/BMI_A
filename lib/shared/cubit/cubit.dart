import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)',
        )
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          // setState(() {
          //   tasks = value;
          //   print(tasks);
          // });
        });
        //{id: 1, title: first task, date: 02222, time: 891, status: new}
        print('database opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database!.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO Test(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted success');
      }).catchError((error) {
        print('Error When Inserting New Record  ${error.toString()}');
      });
      return Future(() => null);
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery('SELECT * FROM Test');
  }

}