class TestChapter {
  int? chapterId;
  int? courseId;
  int? marks;
  String? chapterName;
  String? description;
  int? quesNum;
  int? quesTime;
  String? startTime;
  String? endTime;
  String? lecturer;

  TestChapter(
      {this.chapterId,
      this.courseId,
      this.chapterName,
      this.description,
      this.marks,
      this.quesNum,
      this.quesTime,
      this.startTime,
      this.lecturer,
      this.endTime});

  factory TestChapter.fromJson(Map<String, dynamic> json) {
    return TestChapter(
      chapterId: json['chapterId'],
      courseId: json['courseId'],
      marks: json['marks'],
      chapterName: json['chapterName'],
      description: json['chapterDescrip'],
      quesNum: json['quesNum'],
      quesTime: json['quesTime'],
      startTime: json['startTime'].toString(),
      endTime: json['endTime'].toString(),
      lecturer: json['lecturer'],
    );
  }
}
