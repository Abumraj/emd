class Statuz {
  int? id;
  String url;
  String type;
  String? caption;
  String level;
  String time;
  Statuz(
      {this.id = 0,
      required this.url,
      required this.type,
      required this.time,
      this.caption,
      required this.level});

  factory Statuz.fromJson(Map<String, dynamic> json) {
    return Statuz(
      url: json['url'],
      type: json['type'],
      caption: json['caption'],
      level: json['level'],
      time: json['time'],
    );
  }
}
