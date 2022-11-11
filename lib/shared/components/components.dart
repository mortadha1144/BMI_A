import 'package:flutter/material.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  required Function() onPressed,
  required String text,
})=>Container(
  width: width,
  height: 40,
  color: background,
  child: MaterialButton(
    onPressed: onPressed,
    child:  Text(
      text.toUpperCase(),
      style: const TextStyle(color: Colors.white),
    ),
  ),
);