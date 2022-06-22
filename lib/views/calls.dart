import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  //routes
  static String routeName = '/calls';
  const Calls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'No Recent Calls',
        style: TextStyle(
            fontFamily: 'Helvetica', fontSize: 22, color: Colors.black),
      )),
    );
  }
}
