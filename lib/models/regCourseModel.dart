class RegCourse {
  int? courseId;
  String? courseName;
  String? coursecode;
  String? status;
  int? unit;
  int? progress;
  String? courseChatLink;
  int? id;

  RegCourse(
      {this.courseId,
      this.courseName,
      this.coursecode,
      this.status,
      this.unit,
      this.progress,
      this.courseChatLink,
      this.id});

  factory RegCourse.fromJson(Map<String, dynamic> json) {
    return RegCourse(
      courseId: json['courseId'],
      courseName: json['courseName'],
      coursecode: json['coursecode'],
      status: json['status'],
      unit: json['unit'],
      progress: json['progress'],
      courseChatLink: json['courseChatLink'],
    );
  }
  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "coursecode": coursecode,
        "status": status,
        "unit": unit,
        "progress": progress,
        "courseChatLink": courseChatLink,
      };
}
