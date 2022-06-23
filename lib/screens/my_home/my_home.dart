// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:re_whatsapp/screens/my_home/tabs.dart';
import '../../widgets/app_bar.dart';

class MyHome extends StatelessWidget {
  static String routeName = '/myhome';
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: Column(
            children: const [
              MyAppBar(),
              Expanded(
                child: MyTab(),
              )
            ],
          )),
    );
  }
}
