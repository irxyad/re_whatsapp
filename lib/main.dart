import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re_whatsapp/utils/routes_utils.dart';

import 'material/colors/mycolors.dart';
import 'navigation_bar.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MyColor.greenWhatsApp));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redesign WhatsApp',
      initialRoute: NavigationPage.routeName,
      routes: appRoutes,
      theme: ThemeData(
        backgroundColor: MyColor.greyBG,
        bottomAppBarColor: MyColor.greenWhatsApp,
        brightness: Brightness.light,
      ),
    );
  }
}
