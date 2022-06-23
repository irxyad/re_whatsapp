import 'package:flutter/widgets.dart';
import 'package:re_whatsapp/navigation_bar.dart';
import 'package:re_whatsapp/screens/calls/calls.dart';
import 'package:re_whatsapp/screens/my_home/my_home.dart';
import 'package:re_whatsapp/screens/settings/settings.dart';
import 'package:re_whatsapp/screens/status/status.dart';

import '../screens/calls/calls.dart';

final Map<String, WidgetBuilder> appRoutes = {
  MyHome.routeName: (context) => const MyHome(),
  Status.routeName: (context) => const Status(),
  Calls.routeName: (context) => const Calls(),
  Settings.routeName: (context) => const Settings(),
  NavigationPage.routeName: (context) => const NavigationPage(),
};
