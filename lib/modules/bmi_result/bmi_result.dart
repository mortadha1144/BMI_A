import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  const BmiResult(
      {required this.isMail,
      required this.result,
      required this.age,
      super.key});

  final bool isMail;
  final double result;
  final int age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMail ? 'Male' : 'Female'}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'Result : ${result.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age : $age',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
