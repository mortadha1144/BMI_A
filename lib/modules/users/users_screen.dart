import 'package:flutter/material.dart';

import '../../models/user/user.dart';


class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  final List<UserModel> users = const [
    UserModel(
      id: 1,
      name: 'mortadha naser',
      phone: '07700146084',
    ),
    UserModel(
      id: 1,
      name: 'mohammed qasim',
      phone: '07712345628',
    ),
    UserModel(
      id: 1,
      name: 'hayder hussein',
      phone: '07714582216',
    ),
    UserModel(
      id: 1,
      name: 'mortadha naser',
      phone: '07700146084',
    ),
    UserModel(
      id: 1,
      name: 'mohammed qasim',
      phone: '07712345628',
    ),
    UserModel(
      id: 1,
      name: 'hayder hussein',
      phone: '07714582216',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: users.length),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
             CircleAvatar(
              radius: 20,
              child: Text(
                '${user.id}',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:  [
                Text(
                  user.name,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.phone,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      );
}
