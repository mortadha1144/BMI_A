import 'package:flutter/material.dart';
import 'package:udemy/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy/modules/new_tasks/new_tasks_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          titles[currentIndex],
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          // try{
          //   var name= await getName();
          //   print(name);
          //   throw('some error !!!!');
          // }catch(error){
          //   print('error ${error.toString()}');
          // }

          getName().then((value) {
            print(value);
            print('osama');
           throw('انا عملت ايرور !!!!') ;
          }).catchError((error) {
            print('error is ${error.toString()}');
          });
        },
        child: const Icon(Icons.add),
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

  Future<String> getName() async {
    return 'Ahmed Ali';
  }
}
