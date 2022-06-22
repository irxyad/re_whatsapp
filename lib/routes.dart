import 'package:flutter/widgets.dart';
import 'package:re_whatsapp/navigation_bar.dart';
import 'package:re_whatsapp/views/calls.dart';
import 'package:re_whatsapp/views/my_home.dart';
import 'package:re_whatsapp/views/settings.dart';
import 'package:re_whatsapp/views/status.dart';

final Map<String, WidgetBuilder> routes = {
  MyHome.routeName: (context) => const MyHome(),
  Status.routeName: (context) => const Status(),
  Calls.routeName: (context) => const Calls(),
  Settings.routeName: (context) => const Settings(),
  NavigationPage.routeName: (context) => const NavigationPage(),
};
