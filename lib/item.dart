import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item extends StatelessWidget {
  final String value;

  const Item({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    var isChecked = false.obs;
    return Obx(() => Card(
          color: isChecked.isTrue ? Colors.grey.shade200 : Colors.white,
          elevation: 2,
          child: ListTile(
            leading: Text(
              value,
              style: TextStyle(fontSize: 25),
            ),
            trailing: Obx(() => Checkbox(
                  value: isChecked.value,
                  onChanged: (bool? newvalue) {
                    isChecked.value = newvalue!;
                  },
                )),
          ),
        ));
  }
}
