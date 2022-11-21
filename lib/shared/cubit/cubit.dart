import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

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

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> tasks = [];

  void createDatabase() {
    openDatabase(
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
        getDataFromDatabase(database);
        //{id: 1, title: first task, date: 02222, time: 891, status: new}
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Test(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted success');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record  ${error.toString()}');
      });
      return Future(() => null);
    });
  }

  void getDataFromDatabase(database) {
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM Test').then((value) {
      tasks = value;
      print(tasks);
      value.forEach((element) {
        print(element['status']);
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
        'UPDATE Test SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(AppUpdateDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShowon,
    required IconData icon,
  }) {
    isBottomSheetShown = isShowon;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeMode() {
    isDark=!isDark;
    emit(AppChangeModeState());
  }
}
