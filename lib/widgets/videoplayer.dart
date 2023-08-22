import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DownloadTasker {
  String taskId;
  final String filename;
  DownloadTaskStatus status;
  double progress;
  DownloadTasker({
    required this.filename,
    required this.taskId,
    required this.status,
    required this.progress,
  });
}

class VideoPlayers extends StatefulWidget {
  final List<BetterPlayerDataSource> playList;
  final int index;

  const VideoPlayers({
    Key? key,
    required this.playList,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  final ReceivePort _port = ReceivePort();
  BetterPlayerController? _betterPlayerController;
  int index = 0;
  bool isLoading = false;
  bool isLoading1 = false;
  List<bool> isExist = [];
  Map<String, DownloadTasker> downloadTasks = {};
  Directory? appDocDir;
  @override
  void initState() {
    index = widget.index;
    _initializePlayer(widget.index);
    checkVideoFileExists();
    super.initState();
    secureScreen();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      final task =
          downloadTasks.values.firstWhere((element) => element.taskId == id);
      setState(() {
        downloadTasks[task.filename] = DownloadTasker(
            taskId: id,
            status: status,
            progress: progress.toDouble(),
            filename: task.filename);
      });
    });
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void _initializePlayer(int indez) {
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            autoPlay: true,
            aspectRatio: 16 / 9,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                progressBarHandleColor: Colors.purple,
                progressBarPlayedColor: Colors.purple,
                controlsHideTime: Duration(seconds: 1),
                controlBarColor: Colors.black54)),
        betterPlayerPlaylistConfiguration: BetterPlayerPlaylistConfiguration(
          loopVideos: false,
        ),
        betterPlayerDataSource: widget.playList[indez]);
    _betterPlayerController!.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        if (indez != widget.playList.length - 1) {
          setState(() {
            index = indez + 1;
            int currentIndex = (indez + 1) % widget.playList.length;
            _betterPlayerController!
                .setupDataSource(widget.playList[currentIndex]);
          });
        } else {
          Get.snackbar("End of video list", "Starting from the beginning",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.purple,
              colorText: Colors.white);
          setState(() {
            _betterPlayerController!.setupDataSource(widget.playList[0]);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _betterPlayerController!.dispose();
    _unbindBackgroundIsolate();

    super.dispose();
  }

  checkVideoFileExists() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();

    for (var _task in getTasks!) {
      setState(() {
        downloadTasks[_task.filename!] = DownloadTasker(
            taskId: _task.taskId,
            status: _task.status,
            progress: _task.progress.toDouble(),
            filename: _task.filename!);
        // if (getTasks.length > 0) {
        //   isExist[index] = true;
        // }
      });
    }
  }

  void changeTaskID(String taskid, String newTaskID) {
    var task =
        downloadTasks.values.firstWhere((element) => element.taskId == taskid);
    setState(() {
      task.taskId = newTaskID;
      // downloadTasks[task.filename]!.taskId = newTaskID;
    });
  }

  Future<void> _doSimulateDownload(videoName, url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final dir = await getApplicationDocumentsDirectory();
      var _localPath = dir.path + videoName;
      final savedDir = Directory(_localPath);
      await savedDir.create(recursive: true).then((value) async {
        var taskId = await FlutterDownloader.enqueue(
          url: url,
          fileName: videoName,
          savedDir: _localPath,
          showNotification: true,
          openFileFromNotification: false,
        );
        setState(() {
          downloadTasks[videoName] = DownloadTasker(
              taskId: taskId!,
              status: DownloadTaskStatus.running,
              progress: 0,
              filename: url);
        });
      });
    }
  }

  void playVideoAtIndex(int indexes) {
    setState(() {
      isLoading1 = true;
    });
    index = indexes;
    // _betterPlayerController!.
    _betterPlayerController!.dispose();
    _initializePlayer(indexes);
    // bool? isReady = _betterPlayerController!.isVideoInitialized();

    setState(() {
      isLoading1 = false;
    });
    // if (isReady!) {
    // }
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.playList[index].notificationConfiguration!.title!),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.purple))
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                    child: isLoading1
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.purple))
                        : AspectRatio(
                            aspectRatio: 16 / 9,
                            child: BetterPlayer(
                                controller: _betterPlayerController!),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_up_off_alt_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_down_alt_rounded,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemCount: widget.playList.length,
                        itemBuilder: (_, int indexes) {
                          BetterPlayerDataSource _videoList =
                              widget.playList[indexes];
                          final taskId = downloadTasks[
                                  _videoList.notificationConfiguration!.title]
                              ?.taskId;
                          final progress = downloadTasks[_videoList
                                      .notificationConfiguration!.title]
                                  ?.progress ??
                              0.0;
                          final status = downloadTasks[_videoList
                                      .notificationConfiguration!.title]
                                  ?.status ??
                              DownloadTaskStatus.undefined;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTileTheme(
                              minVerticalPadding: 2.0,
                              contentPadding: EdgeInsets.all(5),
                              selectedColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                  selectedTileColor: Colors.white,
                                  selectedColor: Colors.purple,
                                  selected: indexes == index ? true : false,
                                  onTap: () {
                                    setState(() {
                                      playVideoAtIndex(indexes);
                                    });
                                  },
                                  leading: Container(
                                    width: 100,
                                    height: 70,
                                    child: CachedNetworkImage(
                                      imageUrl: _videoList
                                          .notificationConfiguration!.imageUrl!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                          child:
                                              const CircularProgressIndicator(
                                        color: Colors.purple,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        child: Image.asset(
                                            "images/uniappLogo.png"),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _videoList
                                        .notificationConfiguration!.title!,
                                    style: TextStyle(
                                        color: indexes == index
                                            ? Colors.purple
                                            : Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text.rich(
                                    TextSpan(
                                        text: _videoList
                                            .notificationConfiguration!
                                            .author!),
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: indexes == index
                                          ? Colors.purple
                                          : Colors.white,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                      width: 45,
                                      child: status ==
                                              DownloadTaskStatus.running
                                          ? CircularPercentIndicator(
                                              radius: 20,
                                              progressColor: Colors.purple,
                                              lineWidth: 2,
                                              percent: progress / 100,
                                              center: InkWell(
                                                  child: InkWell(
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.red,
                                                ),
                                                onTap: () async {
                                                  FlutterDownloader.cancel(
                                                      taskId: taskId!);
                                                },
                                              )))
                                          : status ==
                                                  DownloadTaskStatus.canceled
                                              ? InkWell(
                                                  child: Icon(
                                                    Icons.cached_rounded,
                                                    color: Colors.green,
                                                  ),
                                                  onTap: () async {
                                                    FlutterDownloader.retry(
                                                            taskId: taskId!)
                                                        .then(
                                                      (newTaskID) =>
                                                          changeTaskID(taskId,
                                                              newTaskID!),
                                                    );
                                                  },
                                                )
                                              : status ==
                                                      DownloadTaskStatus
                                                          .complete
                                                  ? InkWell(
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onTap: () async {
                                                        Get.snackbar(
                                                            "Delete this video permanetly?",
                                                            "You will lose this video permanently",
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM,
                                                            backgroundColor:
                                                                Colors.purple,
                                                            colorText:
                                                                Colors.white,
                                                            mainButton:
                                                                TextButton(
                                                                    onPressed:
                                                                        (() {
                                                                      widget
                                                                          .playList
                                                                          .removeAt(
                                                                              index);
                                                                      FlutterDownloader.remove(
                                                                          taskId:
                                                                              taskId!,
                                                                          shouldDeleteContent:
                                                                              true);
                                                                    }),
                                                                    child: Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )));
                                                      },
                                                    )
                                                  : status ==
                                                          DownloadTaskStatus
                                                              .failed
                                                      ? InkWell(
                                                          child: Icon(
                                                            Icons
                                                                .cached_rounded,
                                                            color:
                                                                Colors.purple,
                                                          ),
                                                          onTap: () async {
                                                            FlutterDownloader.retry(
                                                                    taskId:
                                                                        taskId!)
                                                                .then(
                                                              (newTaskID) =>
                                                                  changeTaskID(
                                                                      taskId,
                                                                      newTaskID!),
                                                            );
                                                          },
                                                        )
                                                      // : isExist[indexes]
                                                      //     ? InkWell(
                                                      //         child: Icon(
                                                      //           Icons.delete,
                                                      //           color:
                                                      //               Colors.red,
                                                      //         ),
                                                      //         onTap:
                                                      //             () async {},
                                                      //       )
                                                      : InkWell(
                                                          child: Icon(
                                                            Icons.download,
                                                            color: indexes ==
                                                                    index
                                                                ? Colors.purple
                                                                : Colors.white,
                                                          ),
                                                          onTap: () async {
                                                            _doSimulateDownload(
                                                                _videoList
                                                                    .notificationConfiguration!
                                                                    .title!,
                                                                _videoList.url);
                                                          },
                                                        ))),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
