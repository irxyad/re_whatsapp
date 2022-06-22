// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../material/colors/mycolors.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);
  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  List chats = [];
  @override
  void initState() {
    jsonData();
    super.initState();
  }

//Read json file
  jsonData() async {
    await rootBundle.loadString('assets/json/list_chats.json').then((value) {
      final data = json.decode(value);
      setState(() {
        chats = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Colors.purple,
                Colors.transparent,
              ],
              stops: const [
                0.0,
                0.025,
              ], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: chats.isEmpty
              ? Center(
                  child: Text(
                  'No Message',
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 16,
                      color: Colors.black),
                ))
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final item = chats[index];
                    final deletedName = chats[index]["name"];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 65,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            clipBehavior: Clip.antiAlias,
                            child: Slidable(
                              key: Key(item.toString()),
                              direction: Axis.horizontal,
                              endActionPane: ActionPane(
                                  extentRatio: 0.170,
                                  motion: ScrollMotion(),
                                  children: [
                                    // child:
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chats.removeAt(index);
                                          });
                                          // Then show a snackbar.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                "Chat $deletedName telah di hapus"),
                                            clipBehavior: Clip.antiAlias,
                                            duration: Duration(seconds: 1),
                                            action: SnackBarAction(
                                                label: 'Urungkan',
                                                onPressed: () {
                                                  setState(() {
                                                    chats.insert(index, item);
                                                  });
                                                }),
                                          ));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Trash.svg',
                                              color: Colors.white,
                                            ),
                                            Spacer(),
                                            Text(
                                              'Delete',
                                              style: TextStyle(
                                                  fontFamily: 'Helvetica',
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 3),
                                shadowColor:
                                    MyColor.greenWhatsApp.withOpacity(.5),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: Container(
                                    height: 74,
                                    color: Colors.transparent,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Image
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  useSafeArea: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      profile(index));
                                            },
                                            child: Container(
                                              height: 61,
                                              width: 61,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          chats[index]
                                                              ['picture']),
                                                      fit: BoxFit.cover)),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                    height: 12,
                                                    width: 12,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              int.parse(chats[
                                                                      index]
                                                                  ["Bactive"])),
                                                          width: 2.5,
                                                          style: BorderStyle
                                                              .solid),
                                                      color: Color(int.parse(
                                                          chats[index]
                                                              ["active"])),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 11,
                                          ),
                                          //Content
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      chats[index]['name'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'HelveticaBold',
                                                          color: MyColor.black),
                                                    ),
                                                    Text(
                                                      chats[index]['time'],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Helvetica',
                                                          color: Color(
                                                              int.parse(chats[
                                                                      index][
                                                                  'colorTime']))),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      chats[index]['theirChat'],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Helvetica',
                                                          color: MyColor.black),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        color: MyColor
                                                            .greenWhatsApp,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        chats[index]
                                                            ['chatCount'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Helvetica',
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
    );
  }

  profile(int index) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Container(
                  height: Get.height / 2,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.black.withOpacity(.2),
                                        child: Image.asset(
                                          chats[index]['picture'],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                clipBehavior: Clip.antiAlias,
                                height: 300,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                    ),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(chats[index]['picture']),
                                        fit: BoxFit.cover))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chats[index]['name'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'HelveticaBold',
                                        color: MyColor.black),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.blue.shade300),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue.shade500,
                                                    child: Icon(Icons
                                                        .message_outlined)),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  'Chat',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Helvetica',
                                                      color: MyColor.black),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.green.shade300),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green.shade500,
                                                    child: Icon(
                                                        Icons.call_outlined)),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  'Call',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Helvetica',
                                                      color: MyColor.black),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.purple.shade300),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.purple.shade500,
                                                    child: Icon(Icons
                                                        .video_call_outlined)),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  'Video Call',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Helvetica',
                                                      color: MyColor.black),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
