class VideoList {
  int? videoId;
  String? videoName;
  String? videoDescript;
  String? videoSize;
  String? videoUrl;
  String? thumbUrl;
  String? duration;
  String? visible;
  String? author;
  VideoList(
      {this.videoName,
      this.videoSize,
      this.visible,
      this.videoDescript,
      this.thumbUrl,
      this.duration,
      this.videoUrl,
      this.videoId,
      this.author});

  factory VideoList.fromJson(Map<String, dynamic> json) {
    return VideoList(
      thumbUrl: json["thumbUrl"],
      videoUrl: json["videoUrl"],
      visible: json["visible"],
      videoName: json["videoName"],
      videoSize: json["videoSize"],
      duration: json["duration"],
      videoDescript: json["videoDescript"],
      author: json["author"],
      videoId: json["videoId"],
    );
  }

  set id(int id) {}
  Map<String, dynamic> toJson() => {
        "thumbUrl": thumbUrl,
        "videoUrl": videoUrl,
        "videoName": videoName,
        "videoSize": videoSize,
        "duration": duration,
        "videoDescript": videoDescript,
        "author": author,
        "videoId": videoId,
      };
}
