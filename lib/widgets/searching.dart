import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re_whatsapp/material/colors/mycolors.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  List akun = [];
  bool unread = true;
  @override
  void initState() {
    jsonData();
    super.initState();
    // _loadLocalJsonData();
  }

  jsonData() async {
    await rootBundle.loadString('assets/json/list_chats.json').then((value) {
      final data = json.decode(value);
      // wisata = data[''];
      setState(() {
        akun = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.greenWhatsApp,
        title: TextFormField(
          style: TextStyle(
              fontFamily: 'HelveticaBold',
              fontSize: 16,
              color: Colors.white.withOpacity(.5)),
          cursorHeight: 20,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                  fontFamily: 'HelveticaBold',
                  fontSize: 16,
                  color: Colors.white.withOpacity(.5))),
          autofillHints: const {"Ucu", "Loli"},
          autofocus: true,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
