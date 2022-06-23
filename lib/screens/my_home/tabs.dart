// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:re_whatsapp/material/colors/mycolors.dart';
import 'my_tabs/chats_tab.dart';
import 'my_tabs/group_tab.dart';

class MyTab extends StatelessWidget {
  const MyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            color: Color(0xFFF3F4F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              isScrollable: false,
              tabs: const [
                Tab(child: Text("Chats")),
                Tab(child: Text("Groups")),
              ],
              labelStyle: TextStyle(fontSize: 16, fontFamily: 'HelveticaBold'),
              labelColor: MyColor.greenWhatsApp,
              enableFeedback: true,
              splashFactory: NoSplash.splashFactory,
              unselectedLabelColor: MyColor.greyText,
              automaticIndicatorColorAdjustment: false,
              indicatorColor: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 80),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: const [ChatTab(), GroupTab()]),
          ),
        ),
      ),
    );
  }
}
