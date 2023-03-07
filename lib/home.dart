import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket_list_app/item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var listOfItems = []<String>.obs;
  TextEditingController controller = TextEditingController();
  late List<String>? items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supermarket List"),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Add to your list ",
                    content: TextField(
                      autofocus: true,
                      controller: controller,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.close(0);
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            listOfItems.add(controller.text);
                            final prefs = await SharedPreferences.getInstance()
                                .then((value) {
                              value.setStringList(
                                  "key", listOfItems.value as List<String>);
                              print("saved");
                              controller.clear();
                              Get.close(0);
                            });
                          },
                          child: Text("Add"))
                    ]);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Obx(() => listOfItems.isEmpty
          ? Center(
              child: Text(
                "Add items to your list!",
                style: TextStyle(fontSize: 32),
              ),
            )
          : SingleChildScrollView(
              child: Obx(() => Column(
                    children:
                        listOfItems.map((item) => Item(value: item)).toList(),
                  )))),
      floatingActionButton: IconButton(
          color: Colors.redAccent,
          iconSize: 38,
          onPressed: () async {
            // listOfItems.clear();
          },
          icon: const Icon(Icons.delete)),
    );
  }
}
