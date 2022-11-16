import 'package:flutter/material.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>buildTaskItem(tasks[index]),
      separatorBuilder: (context, index) => Padding(
        padding:const EdgeInsetsDirectional.only(start: 20),
        child: Divider(
          height: 4,
          color: Colors.grey[400],
        ),
      ),
      itemCount: tasks.length,
    );
  }
}
