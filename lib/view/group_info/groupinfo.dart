import 'dart:developer';

import 'package:chat_firebase/controller/home_controller.dart';
import 'package:chat_firebase/helper/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class GroupInfoPage extends StatefulWidget {
  const GroupInfoPage(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.adminName});
  final String groupId;
  final String groupName;
  final String adminName;

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  final HomeController controller = Get.find();
  @override
  void initState() {
    controller.getGroupMembers(widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.groupName} Info"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.exitGroup(
                    groupId: widget.groupId, groupName: widget.groupName);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: StreamBuilder(
        stream: controller.members,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final List? data = snapshot.data["members"];
            if (data != null && data.isNotEmpty) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    String member = data[index].toString().split('_').last;
                    log("$member == ${widget.adminName}");

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        tileColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        leading: CircleAvatar(
                            radius: 30,
                            child: Text(
                              member.substring(0, 1),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            )),
                        title: Text(member.toUpperCase()),
                        trailing: member == widget.adminName.split("_").last
                            ? const Text('Admin')
                            : null,
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("No Members in this Group"),
              );
            }
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
