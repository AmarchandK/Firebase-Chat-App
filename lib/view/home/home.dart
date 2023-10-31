import 'dart:developer';

import 'package:chat_firebase/controller/auth_controller.dart';
import 'package:chat_firebase/controller/home_controller.dart';
import 'package:chat_firebase/helper/global_widgets.dart';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/view/auth/widgets/fields.dart';
import 'package:chat_firebase/view/home/group_tile_widget.dart';
import 'package:chat_firebase/view/profile/profile.dart';
import 'package:chat_firebase/view/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final LogInController logInController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const Icon(Icons.person, size: 160),
            Text(
              homeController.userName ?? 'Hello Buddy',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            Text(homeController.userEmail ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                )),
            const Divider(color: primaryColor),
            const TileWidget(
              iconData: Icons.groups_2_outlined,
              tittle: "Groups",
            ),
            TileWidget(
              iconData: Icons.person_2_outlined,
              tittle: "Account",
              onTap: () => Get.to(() => ProfilePage(
                    name: homeController.userName ?? "NO NAME",
                    email: homeController.userEmail ?? "NO EMAIL",
                  )),
            ),
            TileWidget(
              iconData: Icons.exit_to_app,
              tittle: "Logout",
              onTap: () => logInController.signOut(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const SearchPage(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(seconds: 1));
              },
              icon: const Icon(Icons.search_sharp))
        ],
        title: const Text('Groups'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: homeController.streamGroupData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["groups"] != null &&
                snapshot.data["groups"].length != 0) {
              final List groupItem = snapshot.data["groups"];
              log(groupItem.toString());
              return ListView.builder(
                itemCount: groupItem.length,
                itemBuilder: (context, index) => GroupTileWidget(
                    groupName: groupItem[index].toString().split('_').last,
                    groupItem: groupItem[index]),
              );
            } else {
              return const Center(child: Text("No Group Found"));
            }
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Create Newone",
              content: Form(
                key: homeController.groupNameKey,
                child: FormFields(
                    hint: "Group Name",
                    icon: Icons.groups_sharp,
                    keybord: TextInputType.name,
                    controller: homeController.groupNameController,
                    error: 'Eneter a Name'),
              ),
              confirm: TextButton(
                  onPressed: () {
                    homeController.createGroup();
                  },
                  child: const Text("Ok")),
              cancel: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")));
        },
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
