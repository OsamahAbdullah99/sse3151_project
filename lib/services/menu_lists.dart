import 'package:flutter/material.dart';
import 'menu_item.dart';

class MenuLists {
  static const List<MenuItem> itemStudentLists = [
    itemProfile,
    itemReport,
    itemChat
  ];
  static const List<MenuItem> itemSecList = [itemLogOut];
  static const List<MenuItem> itemPALists = [itemProfile, itemAdvisee];
  static const List<MenuItem> itemAdviseeLists = [
    itemAddAdvisee,
    itemArchivedAdvisee
  ];

  static const itemProfile = MenuItem(text: 'Profile', icon: Icons.person);
  static const itemAdvisee =
      MenuItem(text: 'Advisee List', icon: Icons.people_alt);
  static const itemAddAdvisee =
      MenuItem(text: 'Add Advisee', icon: Icons.person_add_alt_1_rounded);
  static const itemArchivedAdvisee =
      MenuItem(text: 'Archived Advisee(s)', icon: Icons.archive_rounded);
  static const itemReport =
      MenuItem(text: 'My Reports', icon: Icons.file_present_rounded);
  static const itemChat = MenuItem(text: 'Chat', icon: Icons.chat_rounded);
  static const itemLogOut = MenuItem(text: 'Log Out', icon: Icons.logout);
}
