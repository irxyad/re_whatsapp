import 'package:flutter/material.dart';

class UsersStory extends StatelessWidget {
  const UsersStory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            color: Color(0xFFF3F4F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
      ),
    );
  }
}
