import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../material/colors/mycolors.dart';
import '../widgets/list_contacts.dart';

class Contacts extends StatefulWidget {
  //routes
  static String routeName = '/contacts';
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? contacts;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);
      // ignore: avoid_print
      print(contacts);
      setState(() {});
    }
  }

  void addContacts() async {
    if (await FlutterContacts.requestPermission()) {
      await FlutterContacts.openExternalInsert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Apbar Custom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: MyColor.greenWhatsApp,
                        )),
                    Text(
                      'Contact',
                      style: TextStyle(
                          color: MyColor.greenWhatsApp,
                          fontSize: 24,
                          fontFamily: 'HelveticaBold'),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Search.svg',
                        color: MyColor.greenWhatsApp,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        addContacts();
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundColor: MyColor.greenWhatsApp,
                              child: LottieBuilder.asset(
                                'assets/icons/contact.json',

                                // height: 120,
                                // width: 120,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Add Contact',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'HelveticaBold'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundColor: MyColor.greenWhatsApp,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LottieBuilder.asset(
                                'assets/icons/group.json',

                                // height: 120,
                                // width: 120,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Group Call',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'HelveticaBold'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Content
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: Get.height,
                  width: Get.width,
                  // alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'List Contacts',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Helvetica'),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              contacts != null
                                  ? '${contacts!.length} Contacts'
                                  : 'No Contacts',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Helvetica'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.purple,
                                  Colors.transparent,
                                ],
                                stops: [
                                  0.0,
                                  0.025,
                                ], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: const ListContacts()),
                      )),
                    ],
                  ))),
        ],
      ),
    );
  }
}
