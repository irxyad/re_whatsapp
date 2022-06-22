import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_whatsapp/material/colors/mycolors.dart';

class ConfirmStory extends StatelessWidget {
  const ConfirmStory({
    Key? key,
    required this.image,
    required this.caption,
    required this.state,
  }) : super(key: key);

  final File? image;
  final TextEditingController caption;
  final VoidCallback state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.black.withOpacity(.2),
          child: Center(
              child: Stack(children: [
            Image.file(
              image!,
              height: double.infinity / 2,
              width: double.infinity / 2,
              fit: BoxFit.cover,
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
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'helvetica'),
                        cursorHeight: 18, textAlign: TextAlign.center,
                        // maxLength: 20,
                        cursorWidth: 1,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "You can write Caption here..",
                            hintStyle: TextStyle(color: Colors.white38)),
                        // onEditingComplete: () {
                        //   Navigator.of(context).pop(context);
                        // },

                        controller: caption,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: MyColor.greenWhatsApp,
                      child: IconButton(
                          onPressed: () {
                            // ubah();
                            state();
                            Navigator.of(context).pop(context);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )))

                  // Container(
                  //   alignment: Alignment.center,
                  //   height: 40,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //       color: MyColor.greenWhatsApp,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: const Text(
                  //     "Upload",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 16,
                  //         fontFamily: "Helvetica"),
                  //   ),
                  // ),
                  ),
            )
          ]))),
    );
  }
}
