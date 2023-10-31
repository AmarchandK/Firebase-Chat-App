import 'package:chat_firebase/controller/home_controller.dart';
import 'package:chat_firebase/view/home/group_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<HomeController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.searchGroup();
                    },
                    icon: const Icon(Icons.search))),
          ),
        ),
        body: Obx(
          () => controller.userSearching.value
              ? const Center(child: CircularProgressIndicator.adaptive())
              : controller.userSearchAlready
                  ? ListView.builder(
                      itemCount: controller.searchSnapshot!.docs.length,
                      itemBuilder: (context, index) => GroupTileWidget(
                        groupName: controller.searchSnapshot!.docs[index]
                            ["groupName"],
                        groupItem: controller.searchSnapshot!.docs[index]
                            ["groupId"],
                        widget: controller.userIsInGroup[index]
                            ? const Text("Joined")
                            : ElevatedButton(
                                onPressed: () {}, child: const Text('Join')),
                      ),
                    )
                  : const Center(child: Text("Search Group")),
        ));
  }
}
