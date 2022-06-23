// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../../../material/colors/mycolors.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({Key? key}) : super(key: key);

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: contacts != null
            ? ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: contacts!.length,
                itemBuilder: (context, index) {
                  String num = (contacts![index].phones.isNotEmpty)
                      ? (contacts![index].phones.first.number)
                      : "No Number";

                  return Card(
                    shadowColor: MyColor.greenWhatsApp.withOpacity(.5),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                        height: 74,
                        // color: Colors.red,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Image

                              ProfilePicture(
                                name: contacts![index].name.first,
                                radius: 25,
                                fontsize: 18,
                                random: true,
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              //Content
                              Expanded(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${contacts![index].name.first} ${contacts![index].name.last}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'HelveticaBold',
                                              color: MyColor.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          num,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Helvetica',
                                              color: MyColor.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ])),
                  );
                })
            : Center(child: Text('Kosong')));
  }

  // profile() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pop(context);
  //     },
  //     child: BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  //       child: Container(
  //         height: double.infinity,
  //         width: double.infinity,
  //         color: Colors.black.withOpacity(.2),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //           child: Center(
  //             child: Container(
  //               height: Get.height / 2,
  //               width: Get.width,
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(25)),
  //               child: Column(
  //                 children: [
  //                   Container(
  //                       height: 61,
  //                       width: 61,
  //                       decoration: BoxDecoration(
  //                           color: Colors.transparent,
  //                           borderRadius: BorderRadius.circular(14),
  //                           image: DecorationImage(
  //                               image: AssetImage(chats[0]['picture']),
  //                               fit: BoxFit.cover)))
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
