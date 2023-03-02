import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supermarket_list_app/item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var listOfItems = [].obs;
  TextEditingController controller = TextEditingController();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/items.txt');
  }

  Future<File> writeItems(List items) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$items');
  }

  Future<int> readItems() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      print(contents);
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

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
                            writeItems(listOfItems);
                            controller.clear();
                            Get.close(0);
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
            readItems();
            // listOfItems.clear();
          },
          icon: const Icon(Icons.delete)),
    );
  }
}
