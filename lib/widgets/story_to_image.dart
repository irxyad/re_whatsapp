import 'package:flutter/material.dart';

class StorytoImage extends StatefulWidget {
  final Function(GlobalKey key) builder;
  const StorytoImage({Key? key, required this.builder}) : super(key: key);

  @override
  State<StorytoImage> createState() => _StorytoImageState();
}

class _StorytoImageState extends State<StorytoImage> {
  final globalkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: widget.builder(globalkey),
    );
  }
}
