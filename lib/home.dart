import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket_list_app/item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var listOfItems = [].obs;
  TextEditingController controller = TextEditingController();
  late List<String>? items;
  late List<String> myList;

  void getSavedList() async {
    final prefs = await SharedPreferences.getInstance();
    final listToPull = await prefs.getStringList("key");
    print(listToPull);
    listOfItems.value = List.from(listToPull as Iterable);
  }

  void deleteSaved() async {
    final prefs = await SharedPreferences.getInstance();
    listOfItems.clear();
    await prefs.remove("key");
  }

  @override
  Widget build(BuildContext context) {
    getSavedList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Supermarket List",
          style: TextStyle(fontSize: 28),
        ),
        actions: [
          IconButton(
              onPressed: () {
                deleteSaved();
              },
              icon: Icon(Icons.delete))
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
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
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
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        listOfItems.add(controller.text);
                        final prefs =
                            await SharedPreferences.getInstance().then((value) {
                          myList = List.from(listOfItems);
                          value.setStringList("key", myList);
                          print("saved");
                          controller.clear();
                          Get.close(0);
                        });
                      },
                      child: Text("Add"))
                ]);
          },
        ),
      ),
    );
  }
}
