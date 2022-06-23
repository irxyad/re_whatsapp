import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:re_whatsapp/screens/status/components/profile_pic.dart';
import 'package:social_share/social_share.dart';
import '../../material/colors/mycolors.dart';
import '../../widgets/app_bar.dart';
import 'components/users_story.dart';

class Status extends StatefulWidget {
  //routes
  static String routeName = '/status';
  const Status({Key? key}) : super(key: key);
  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  File? images;
  final jam = DateFormat.Hm().format(DateTime.now());
  final _controller = TextEditingController(text: '');
  // String we'll be changing
  String caption = '';

  @override
  void initState() {
    jsonData();
    super.initState();

    // Simple declarations
    caption = _controller.text;
  }

  List akun = [];

  jsonData() async {
    await rootBundle.loadString('assets/json/list_chats.json').then((value) {
      final data = json.decode(value);
      setState(() {
        akun = data;
      });
    });
  }

  Future<void> shareFile() async {
    await SocialShare.shareInstagramStory(
      images!.path,
    );
  }

//Pick Story
  Future pickImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          preferredCameraDevice: CameraDevice.rear,
          maxHeight: 4000,
          maxWidth: 3000);

      if (image == null) return;
      final File imageTemp = File(image.path);
      // _controller.dispose();
      // final savedImage =
      GallerySaver.saveImage(image.path, toDcim: true, albumName: "Wa");
      return showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) {
            return uploadingStatus(imageTemp, context);
          });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed : $e');
    }
  }

//Uploading Story
  Scaffold uploadingStatus(File? imageTemp, BuildContext context) {
    _controller.clear();
    return Scaffold(
        body:
            // keyStory = key;
            Container(
                height: Get.height,
                width: Get.width,
                color: Colors.black.withOpacity(.2),
                child: Center(
                    child: Stack(children: [
                  Image.file(
                    imageTemp!,
                    height: double.infinity / 2,
                    width: double.infinity / 2,
                    // fit: BoxFit.contain,
                    isAntiAlias: true,
                    filterQuality: FilterQuality.high,
                    scale: .5,
                  ),
                  Center(
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: Get.width,
                          color: Colors.black.withOpacity(.5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: TextField(
                              // autofocus: false,
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'helvetica'),
                              cursorHeight: 18,
                              textAlign: TextAlign.center,
                              // maxLength: 20,
                              cursorWidth: 1,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "You can write Caption here..",
                                  hintStyle: TextStyle(color: Colors.white38)),
                              keyboardType: TextInputType.text,
                              controller: _controller,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                            backgroundColor: MyColor.greenWhatsApp,
                            child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    // images = this.bytes as File?;
                                    images = imageTemp;
                                    caption = _controller.text;
                                    _controller.clearComposing();
                                  });
                                  // ubah();
                                  // state();
                                  Navigator.of(context).pop(context);
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )))),
                  )
                ]))));
  }

//Remove Story
  void removeImage() {
    if (images != null) {
      images = null;
      Navigator.pop(context);
    }
    setState(() {
      images;
    });
  }

// Utama
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: MyColor.greenWhatsApp),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Column(
              children: [
                const MyAppBar(),
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: Get.width,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            images != null
                                ? showDialog(
                                    useSafeArea: false,
                                    context: context,
                                    builder: (context) {
                                      // Timer(const Duration(seconds: 3),
                                      //     () {
                                      //   Navigator.pop(
                                      //       context); // == First dialog closed
                                      // });
                                      return story(caption: _controller.text);
                                    })
                                : const SizedBox();
                          },
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: Stack(
                              children: [
                                images != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          images!,
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const ProfilePic(
                                        h: 90, w: 90, radius: 14),
                                images != null
                                    ? const SizedBox()
                                    : Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            pickImage();
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                              color: MyColor.greenWhatsApp,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                images != null
                                    ? Center(
                                        child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                              Icons.remove_red_eye_outlined,
                                              size: 25,
                                              color: Colors.white),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            akun.length.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                        ],
                                      ))
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        // : GestureDetector(),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            images != null ? '' : pickImage();
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'My Status',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'HelveticaBold'),
                                ),
                                images != null
                                    ? Text(
                                        'Hari ini, $jam',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Helvetica'),
                                      )
                                    : const Text(
                                        'Tap to add status update',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'Helvetica'),
                                      )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const UsersStory()
          ],
        )),
      ),
    );
  }

  //Confirmed Story
  story({required String caption}) {
    //Backgground
    return GestureDetector(
      onHorizontalDragStart: (_) {},
      onVerticalDragStart: (_) {
        showModalBottomSheet(
            useRootNavigator: true,
            clipBehavior: Clip.antiAlias,
            isScrollControlled: true,
            enableDrag: true,
            constraints: const BoxConstraints(maxHeight: 300, minHeight: 100),
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Builder(builder: (
                      context,
                    ) {
                      String lihat = akun.length.toString();
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye_outlined),
                                color: Colors.white,
                              ),
                              Text(
                                'Viewed by : $lihat',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.message_outlined),
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.share_outlined),
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: akun.length,
                                itemBuilder: (context, index) {
                                  String photo = akun[index]['picture'];
                                  String name = akun[index]['name'];
                                  String viewed = akun[index]['viewed'];
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 60,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              // AssetImage(
                                              //     'assets/images/drLina.jpg'),
                                              AssetImage(photo),
                                          radius: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Last seen $viewed yang lalu',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              );
            });
      },
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(.2),
            child: Center(
              child: Stack(children: [
                //Image Story
                Image.file(
                  images!,
                  fit: BoxFit.cover,
                  height: Get.height,
                  width: Get.width,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  // scale: 8,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(.3),
                  ),
                ),
                Center(
                  child: Image.file(
                    images!,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    // scale: 8,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      //Container Profile
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100))),
                            child: Row(
                              children: [
                                //Image Profile
                                const ProfilePic(h: 50, w: 50, radius: 50),
                                const SizedBox(
                                  width: 10,
                                ),
                                //Teks Status Profile
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'My Status',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'HelveticaBold'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Hari ini, $jam',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Helvetica'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    removeStatus(),
                  ],
                ),
                // Caption
                caption == '' ? const SizedBox() : captionStory(caption),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40.0),
                    child: FloatingActionButton(
                      backgroundColor: MyColor.greenWhatsApp,
                      onPressed: () {
                        SocialShare.shareOptions(caption,
                            imagePath: images!.path);
                      },
                      child: const Icon(Icons.share_rounded),
                    ),
                  ),
                )
              ]),
            ),
          )),
    );
  }

//Caption Story
  Center captionStory(String caption) {
    return Center(
      child: ClipRRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              height: 35,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
              ),
              child: Text(
                caption,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )),
      ),
    );
  }

//Button remove status
  GestureDetector removeStatus() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(systemNavigationBarColor: Colors.red));
    return GestureDetector(
      onTap: () {
        //Dialog Remove
        showDialog(
            useSafeArea: false,
            // anchorPoint: Offset(50, 50),
            context: context,
            builder: (context) => Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 140,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: MyColor.greenWhatsApp,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Remove Status?",
                              style: TextStyle(
                                  fontFamily: 'HelveticaBold',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    clipBehavior: Clip.antiAlias,
                                    autofocus: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          color: Colors.white60),
                                    )),
                                TextButton(
                                    clipBehavior: Clip.antiAlias,
                                    autofocus: true,
                                    onPressed: () {
                                      removeImage();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          color: Colors.red),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
      //Background dan Icon
      child: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        bottomLeft: Radius.circular(35))),
                child: SvgPicture.asset(
                    // color: Colors.red,
                    'assets/icons/Trash.svg',
                    color: Colors.red.shade400)),
          ),
        ),
      ),
    );
  }
}
