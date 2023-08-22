class DepartCourse {
  int? courseId;
  String? courseName;
  String? coursecode;
  String? courseStatus;
  int? courseUnit;

  DepartCourse({
    this.courseId,
    this.courseName,
    this.coursecode,
    this.courseStatus,
    this.courseUnit,
  });

  factory DepartCourse.fromJson(Map<String, dynamic> json) {
    return DepartCourse(
      courseId: json['courseId'],
      courseName: json['courseName'],
      coursecode: json['coursecode'],
      courseStatus: json['courseStatus'],
      courseUnit: json['courseUnit'],
    );
  }
}
