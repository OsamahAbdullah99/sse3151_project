class UserUPM {
  final String uid;

  UserUPM({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String upmid;
  final String email;
  final int phoneNumber;

  UserData(
      {required this.uid,
      required this.name,
      required this.upmid,
      required this.email,
      required this.phoneNumber});
}

class UserDisplay {
  final String name;
  final String upmid;
  final String email;
  final int phoneNumber;

  UserDisplay(
      {required this.name,
      required this.upmid,
      required this.email,
      required this.phoneNumber});
}
