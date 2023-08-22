import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:video_player/video_player.dart';

class Unihub extends StatefulWidget {
  final String? customUrl;
  final String? news;
  Unihub({Key? key, this.customUrl, this.news}) : super(key: key);

  @override
  State<Unihub> createState() => _UnihubState();
}

int position = 1;
String website = 'https://unihub.ng/category/campus-foodie';

class _UnihubState extends State<Unihub> {
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.networkUrl(Uri.parse(
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Video Demo', home: Scaffold(body: Center()));
  }
}
