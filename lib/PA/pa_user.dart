class paUser {
  final String uid;

  paUser({required this.uid});

  String? name;
  String? umpid;
  String? semester;
  String? faculty;
  String? email;
  String? wechat;
  String? phoneNumber;
}

class paUserData {
  final String uid;
  final String name;
  final String upmid;
  final String semester;
  final String faculty;
  final String email;
  final String wechat;
  final String phoneNumber;

  paUserData(
      {required this.uid,
      required this.name,
      required this.upmid,
      required this.semester,
      required this.faculty,
      required this.email,
      required this.wechat,
      required this.phoneNumber});
}
