import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:udemy/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
   HomeLayout({Key? key}) : super(key: key);





  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    ).then((value) {
                      getDataFromDatabase(database).then((value) {
                        Navigator.pop(context);
                        // setState(() {
                        //   isBottomSheetShown = false;
                        //   fabIcon = Icons.edit;
                        //   tasks = value;
                        //   print(tasks);
                        // });
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
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  isBottomSheetShown = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (value) {

                cubit.changeIndex(value);
                // setState(() {
                //   currentIndex = value;
                // });
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
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Ahmed Ali';
  // }

}
