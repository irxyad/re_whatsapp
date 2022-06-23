import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:re_whatsapp/material/colors/mycolors.dart';
import 'package:re_whatsapp/screens/calls/calls.dart';
import 'package:re_whatsapp/screens/contacts/contacts.dart';
import 'package:re_whatsapp/screens/my_home/my_home.dart';
import 'package:re_whatsapp/screens/settings/settings.dart';
import 'package:re_whatsapp/screens/status/status.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'controller/navbar_controller.dart';

class NavigationPage extends StatefulWidget {
  // initial route
  static String routeName = "/navbar";
  const NavigationPage({Key? key}) : super(key: key);
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  BottomNavbar bottomNavbarku = Get.put(BottomNavbar());
  final TextEditingController _pesan = TextEditingController();

// item Page Navbar
  var screens = [
    const MyHome(),
    const Status(),
    const Calls(),
    const Settings(),
  ];

  // Launch WhatsApp
  launchWhatsApp() async {
    _pesan.clear();

    showModalBottomSheet(
        // constraints: const BoxConstraints.expand(),
        isScrollControlled: false,
        backgroundColor: MyColor.greenWhatsApp,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // flex: 2,
                  child: SingleChildScrollView(
                    child: TextField(
                      style: const TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16,
                          color: Colors.white),
                      toolbarOptions: const ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      autofocus: false,
                      textInputAction: TextInputAction.newline,
                      onEditingComplete: () {
                        Navigator.canPop(context);
                      },
                      cursorColor: Colors.white,
                      maxLines: null,
                      minLines: null,
                      scrollController:
                          ScrollController(keepScrollOffset: true),
                      expands: false,
                      decoration: InputDecoration(
                        // constraints: BoxConstraints(maxWidth: double.infinity),
                        alignLabelWithHint: true,
                        labelText: 'Masukkan Pesan',
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(.2)),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      controller: _pesan,
                      keyboardType: TextInputType.multiline,
                      cursorHeight: 20,
                      textAlign: TextAlign.start,
                      // scrollPadding: EdgeInsets.only(bottom: 40),
                    ),
                  ),
                ),
                IconButton(
                    // disabledColor: Colors.red,
                    splashColor: const Color.fromARGB(255, 6, 75, 67),
                    splashRadius: 20,
                    highlightColor: Colors.transparent,
                    alignment: Alignment.center,
                    color: Colors.white,
                    onPressed: () {
                      final link = WhatsAppUnilink(
                        text: _pesan.text,
                      );
                      launchUrl(Uri.parse('$link'));
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 20,
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: MyColor.greenWhatsApp,
          elevation: 0,
          child: iconsFloatBTN()),
      body: SafeArea(
        bottom: false,
        child: Obx(
          (() => IndexedStack(
                index: bottomNavbarku.selectedIndex.value,
                children: screens,
              )),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            notchMargin: 3.0,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BottomNavigationBar(
                backgroundColor: MyColor.greenWhatsApp,
                selectedFontSize: 12,
                onTap: (index) {
                  bottomNavbarku.changeIndex(index);
                },
                currentIndex: bottomNavbarku.selectedIndex.value,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                elevation: 0,
                selectedItemColor: Colors.white,
                selectedLabelStyle:
                    const TextStyle(fontFamily: 'HelveticaBold', height: 1.5),
                type: BottomNavigationBarType.fixed,
                items: itemBotNavbar),
          )),
    );
  }

//Icons FLoatBTN
  Obx iconsFloatBTN() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (bottomNavbarku.selectedIndex.value == 0) ...[
            GestureDetector(
              onTap: () {
                launchWhatsApp();
              },
              child: SvgPicture.asset(
                'assets/icons/chat.svg',
                height: 25,
                width: 25,
              ),
            ),
          ] else if (bottomNavbarku.selectedIndex.value == 1) ...[
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/Image.svg',
                height: 25,
                width: 25,
              ),
            ),
          ] else if (bottomNavbarku.selectedIndex.value == 2) ...[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Contacts()),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/Calling.svg',
                height: 25,
                width: 25,
              ),
            ),
          ] else if (bottomNavbarku.selectedIndex.value == 3) ...[
            SvgPicture.asset(
              'assets/icons/Settings.svg',
              height: 25,
              width: 25,
            ),
          ]
        ],
      ),
    );
  }

// Item Navbar
  List<BottomNavigationBarItem> get itemBotNavbar {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/home_unselected.svg',
          height: 25,
        ),
        label: 'HOME',
        activeIcon:
            SvgPicture.asset('assets/icons/home_selected.svg', height: 25),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/status_unselected.svg',
          height: 25,
        ),
        label: 'STATUS',
        activeIcon:
            SvgPicture.asset('assets/icons/status_selected.svg', height: 25),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/calls_unselected.svg',
          height: 25,
        ),
        label: 'CALLS',
        activeIcon:
            SvgPicture.asset('assets/icons/calls_selected.svg', height: 25),
      ),
      const BottomNavigationBarItem(
        icon: CircleAvatar(
          backgroundImage: AssetImage('assets/images/pic.png'),
          radius: 20,
        ),
        label: 'Irxyad',
      ),
    ];
  }
}
