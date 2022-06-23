import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    required this.h,
    required this.w,
    required this.radius,
  }) : super(key: key);

  final double h, w, radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Image(
        isAntiAlias: true,
        image: AssetImage('assets/images/pic.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
