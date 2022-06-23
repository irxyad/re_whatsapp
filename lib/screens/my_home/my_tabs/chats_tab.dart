// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../../material/colors/mycolors.dart';
import '../../../widgets/data_json.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);
  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final JsonData jsData = JsonData();

  @override
  void initState() {
    JsonData().akun;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: MyColor.greenWhatsApp,
      semanticsLabel: 'Wait',
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: Colors.white,
      onRefresh: () async {
        setState(() {
          jsData.jsonData();
        });

        Future.delayed(Duration(seconds: 1))
            .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${jsData.akun.length} chat telah di perbaharui'),
                    duration: Duration(seconds: 2),
                  ),
                ));
      },
      child: Scaffold(
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
            child: jsData.akun.isEmpty
                ? ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.height / 3),
                        child: Center(
                          child: Text(
                            'No Message',
                            style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    padding: EdgeInsets.only(top: 10),
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    addAutomaticKeepAlives: true,
                    clipBehavior: Clip.antiAlias,
                    itemCount: jsData.akun.length,
                    itemBuilder: (context, index) {
                      final item = jsData.akun[index];
                      final deletedName = jsData.akun[index]["name"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(18)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(18),
                                child: Slidable(
                                  key: Key(item.toString()),
                                  direction: Axis.horizontal,
                                  endActionPane: ActionPane(
                                      extentRatio: 0.175,
                                      motion: ScrollMotion(),
                                      children: [
                                        // child:
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                jsData.akun.removeAt(index);
                                              });
                                              // Then show a snackbar.
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    "Chat $deletedName telah di hapus"),
                                                clipBehavior: Clip.antiAlias,
                                                duration: Duration(seconds: 1),
                                                action: SnackBarAction(
                                                    label: 'Urungkan',
                                                    onPressed: () {
                                                      setState(() {
                                                        jsData.akun.insert(
                                                            index, item);
                                                      });
                                                    }),
                                              ));
                                            },
                                            child: SizedBox(
                                              height: 65,
                                              width: 42,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/Trash.svg',
                                                    color: Color(0xFFF3F4F8),
                                                  ),
                                                  Spacer(),
                                                  Text('Delete',
                                                      style: TextStyle(
                                                        fontFamily: 'Helvetica',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFF3F4F8),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 3),
                                      shadowColor:
                                          MyColor.greenWhatsApp.withOpacity(.5),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Container(
                                          height: 74,
                                          color: Colors.transparent,
                                          width: Get.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
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
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                jsData.akun[
                                                                        index][
                                                                    'picture']),
                                                            fit: BoxFit.cover)),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                          height: 12,
                                                          width: 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(int.parse(
                                                                    jsData.akun[
                                                                            index]
                                                                        [
                                                                        "Bactive"])),
                                                                width: 2.5,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            color: Color(
                                                                int.parse(jsData
                                                                            .akun[
                                                                        index][
                                                                    "active"])),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            jsData.akun[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'HelveticaBold',
                                                                color: MyColor
                                                                    .black),
                                                          ),
                                                          Text(
                                                            jsData.akun[index]
                                                                ['time'],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Helvetica',
                                                                color: Color(int.parse(
                                                                    jsData.akun[
                                                                            index]
                                                                        [
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
                                                            jsData.akun[index]
                                                                ['theirChat'],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Helvetica',
                                                                color: MyColor
                                                                    .black),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: MyColor
                                                                  .greenWhatsApp,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Text(
                                                              jsData.akun[index]
                                                                  ['chatCount'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  height: 1.5,
                                                                  fontFamily:
                                                                      'Helvetica',
                                                                  color: Colors
                                                                      .white),
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
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
      ),
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
              child: FittedBox(
                fit: BoxFit.contain,
                clipBehavior: Clip.antiAlias,
                child: Container(
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
                                          jsData.akun[index]['picture'],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              alignment: Alignment.topRight,
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
                                    image: AssetImage(
                                        jsData.akun[index]['picture']),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.black.withOpacity(.2),
                                  child: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    jsData.akun[index]['name'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'HelveticaBold',
                                        color: MyColor.black),
                                  ),
                                  Row(
                                    children: [
                                      IconConnect(
                                        press: () {
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //   key: mykey,
                                          //   behavior: SnackBarBehavior.floating,
                                          //   content: Text(
                                          //       'Fitur Chat belum tersedia'),
                                          //   duration: Duration(seconds: 2),
                                          // ));
                                        },
                                        bgColor: Colors.blue.shade600,
                                        icon: Icons.message_rounded,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      IconConnect(
                                        press: () {},
                                        bgColor: Colors.green.shade800,
                                        icon: Icons.call_rounded,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      IconConnect(
                                          press: () {},
                                          bgColor: Colors.purple.shade600,
                                          icon: Icons.video_call_rounded),
                                      SizedBox(
                                        width: 15.0,
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

class IconConnect extends StatelessWidget {
  const IconConnect({
    Key? key,
    required this.bgColor,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final Color bgColor;
  final IconData icon;
  final Callback press;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: bgColor,
        child: IconButton(
          onPressed: press,
          splashColor: Colors.black.withOpacity(.5),
          icon: Icon(icon),
          splashRadius: 24,
          color: Colors.white,
          iconSize: 24,
        ));
  }
}
