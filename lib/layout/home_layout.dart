import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:udemy/shared/components/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
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

  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();



  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: tasks.isEmpty ?  const Center(child: CircularProgressIndicator()): screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                  (context) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'title must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Title',
                            prefixIcon: Icons.title,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-11-30'),
                              ).then((value) => dateController.text =
                                  DateFormat('dd/MM/yyyy')
                                      .format(value!)
                                      .toString());
                            },
                            validate: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Time',
                            prefixIcon: Icons.calendar_month_outlined,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) =>
                                  timeController.text = value!.format(context));
                            },
                            validate: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Time',
                            prefixIcon: Icons.watch_later_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20,
                )
                .closed
                .then((value) {
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Ahmed Ali';
  // }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        print('database created');
        await db
            .execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)',
        )
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db).then((value) {
          tasks=value;
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

  Future<List<Map>> getDataFromDatabase(database) async{
    return await database!.rawQuery('SELECT * FROM Test');
  }

}
