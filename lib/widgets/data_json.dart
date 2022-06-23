import 'dart:convert';
import 'package:flutter/services.dart';

class JsonData {
  List akun = [];

//Read json file
  jsonData() {
    rootBundle.loadString('assets/json/list_chats.json').then((value) {
      final data = json.decode(value);
      akun = data;
    });
  }
}
