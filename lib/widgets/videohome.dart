import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/repository/apiRepository.dart';
import 'package:uniapp/widgets/videoplayer.dart';
import '../models/videoListModel.dart';
import '../repository/apiRepositoryimplementation.dart';
import '../screens/download.dart';

class VideoInfo extends StatefulWidget {
  final int chapterId;
  final String chapterName;
  const VideoInfo(
      {Key? key, required this.chapterId, required this.chapterName})
      : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());

  late String status;
  List<VideoList> videoList = [];
  List<BetterPlayerDataSource> dataSource = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadChapterList();
  }

  _loadChapterList() async {
    setState(() {
      isLoading = true;
    });
    final result = await _apiRepository.getVideoList(1);
    if (result.isNotEmpty) {
      setState(() {
        videoList.addAll(result);
        videoList.forEach((element) {
          var data = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, "${element.videoUrl}",
              drmConfiguration: BetterPlayerDrmConfiguration(),
              videoFormat: BetterPlayerVideoFormat.other,
              notificationConfiguration: BetterPlayerNotificationConfiguration(
                  showNotification: true,
                  title: element.videoName,
                  author: "${element.videoDescript} By: ${element.author}",
                  imageUrl: element.thumbUrl));
          dataSource.add(data);
        });
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            " ${videoList.length} Videos",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  Get.to(OfflineDownloads());
                }),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.purple),
              )
            : Container(
                child: _listView(),
              ));
  }

  _listView() {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
        : videoList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Videos coming soon.",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: videoList.length,
                itemBuilder: (_, int index) {
                  VideoList _videoList = videoList[index];
                  return ListTile(
                    onTap: () {
                      Get.to(
                        VideoPlayers(
                          playList: dataSource,
                          index: index,
                        ),
                      );
                    },
                    isThreeLine: true,
                    dense: true,
                    enabled: true,
                    leading: Container(
                      // width: 100,
                      // height: 70,
                      child: CachedNetworkImage(
                        imageUrl: _videoList.thumbUrl!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width / 3.2,
                        placeholder: (context, url) => Center(
                            child: const CircularProgressIndicator(
                          color: Colors.purple,
                        )),
                        errorWidget: (context, url, error) => CircleAvatar(
                          child: Image.asset("images/uniappLogo.png"),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      _videoList.videoName.toString(),
                      style: context.textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                            TextSpan(text: _videoList.videoDescript.toString()),
                            softWrap: true,
                            maxLines: 6,
                            style: context.textTheme.bodyText2),
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(text: "By: ", children: [
                                TextSpan(
                                  text: _videoList.author,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.purple[350],
                                  ),
                                )
                              ]),
                              softWrap: true,
                              maxLines: 6,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.purple[500],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text.rich(
                              TextSpan(text: "Accessible till: ", children: [
                                TextSpan(
                                  text: _videoList.visible,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.purple[350],
                                  ),
                                )
                              ]),
                              softWrap: true,
                              maxLines: 6,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.purple[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
  }
}
