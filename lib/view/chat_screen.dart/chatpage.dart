import 'package:chat_firebase/controller/home_controller.dart';
import 'package:chat_firebase/view/chat_screen.dart/widgets/messge_tile.dart';
import 'package:chat_firebase/view/group_info/groupinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.groupId, required this.groupName});
  final String groupId;
  final String groupName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final HomeController controller = Get.find<HomeController>();
  @override
  void initState() {
    controller.getChatAndAdmin(groupId: widget.groupId);
    controller.getGroupMembers(widget.groupId);
    super.initState();
  }

  Stream<QuerySnapshot>? chats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(child: Text(widget.groupName)),
        actions: [
          IconButton(
              onPressed: () => Get.to(
                    () => GroupInfoPage(
                        groupId: widget.groupId,
                        groupName: widget.groupName,
                        adminName: (controller.admin ?? "_").split("_").last),
                  ),
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => controller.sendMessage(widget.groupId),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(Icons.send, color: Colors.white)),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: controller.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : const SizedBox.shrink();
      },
    );
  }
}
