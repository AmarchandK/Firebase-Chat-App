import 'package:chat_firebase/controller/home_controller.dart';
import 'package:chat_firebase/view/chat_screen.dart/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';

class GroupTileWidget extends GetView<HomeController> {
  const GroupTileWidget({
    super.key,
    this.widget,
    required this.groupName,
    required this.groupItem,
  });
  final Widget? widget;

  final String groupItem, groupName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(groupName.substring(0, 1)),
      ),
      title: Text(groupName),
      onTap: () => Get.to(() => ChatScreen(
          groupId: controller.getGroupId(groupItem), groupName: groupName)),
      trailing: widget,
    );
  }
}
