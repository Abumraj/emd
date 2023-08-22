import 'package:flutter/material.dart';

class MoreStories extends StatefulWidget {
  final Widget stor;

  const MoreStories({Key? key, required this.stor}) : super(key: key);
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  // List<StoryItem> storyItem = [
  //   StoryItem.text(
  //     title:
  //         "I guess you'd love to see more of our food. That's great. I guess you'd love to see more of our food. That's great.I guess you'd love to see more of our food. That's great.I guess you'd love to see more of our food. That's great.",
  //     backgroundColor: Colors.blue,
  //   ),
  //   StoryItem.text(
  //     title: "Nice!\n\nTap to continue.",
  //     backgroundColor: Colors.red,
  //     textStyle: TextStyle(
  //       fontFamily: 'Dancing',
  //       fontSize: 40,
  //     ),
  //   ),
  //   StoryItem.pageImage(
  //       url:
  //           "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
  //       caption: "Still sampling",
  //       controller: storyController),
  //   StoryItem.pageImage(
  //       url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
  //       caption: "Working with gifs",
  //       controller: storyController),
  //   StoryItem.pageImage(
  //     url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
  //     caption: "Hello, from the other side",
  //     controller: storyController,
  //   ),
  //   StoryItem.pageImage(
  //     url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
  //     caption: "Hello, from the other side2",
  //     controller: storyController,
  //   ),
  //   StoryItem.pageVideo(
  //       "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  //       caption:
  //           "I guess you'd love to see more of our food. That's great. I guess you'd love to see more of our food. That's great.",
  //       controller: storyController)
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("More"),
      // ),
      body: widget.stor,
    );
  }
}
