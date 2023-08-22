class User {
  String? title;
  String? fullName;
  String? imageUrl;
  String? email;
  String? matricNo;
  int? phoneNo;
  String? department;
  String? sex;
  int? level;

  User(
      {this.department,
      this.fullName,
      this.email,
      this.matricNo,
      this.imageUrl,
      this.phoneNo,
      this.sex,
      this.level,
      this.title});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      imageUrl: json['imageUrl'],
      matricNo: json['matricNo'],
      department: json['department'],
      sex: json['sex'],
      phoneNo: json['phoneNo'],
      title: json['title'],
      level: json['level'],
      email: json['email'],
    );
  }
}
