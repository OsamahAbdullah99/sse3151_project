class studentUser {
  final String uid;

  studentUser({required this.uid});

  String? name;
  String? umpid;
  String? semester;
  String? faculty;
  String? email;
  String? wechat;
  String? phoneNumber;

  // studentUserData(String name, String upmid, String semester, String faculty,
  //     String email, String wechat, String phoneNumber) {
  //   this.name = name;
  //   this.umpid = upmid;
  //   this.semester = semester;
  //   this.faculty = faculty;
  //   this.email = email;
  //   this.wechat = wechat;
  //   this.phoneNumber = phoneNumber;
  // }
}

class studentUserData {
  final String uid;
  final String name;
  final String upmid;
  final String semester;
  final String faculty;
  final String email;
  final String wechat;
  final String phoneNumber;

  studentUserData(
      {required this.uid,
      required this.name,
      required this.upmid,
      required this.semester,
      required this.faculty,
      required this.email,
      required this.wechat,
      required this.phoneNumber});
}