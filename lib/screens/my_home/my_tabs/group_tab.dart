import 'package:flutter/material.dart';

class GroupTab extends StatelessWidget {
  const GroupTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Text(
        "Group",
        style: TextStyle(fontSize: 20, fontFamily: 'HelveticaBold'),
      )),
    );
  }
}
