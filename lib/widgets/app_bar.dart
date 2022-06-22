import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../material/colors/mycolors.dart';
import '../searching.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 40.0, top: 40.0, left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'WhatsApp',
            style: TextStyle(
                color: MyColor.greenWhatsApp,
                fontSize: 24,
                fontFamily: 'HelveticaBold'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Searching()));
            },
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              color: MyColor.greenWhatsApp,
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
