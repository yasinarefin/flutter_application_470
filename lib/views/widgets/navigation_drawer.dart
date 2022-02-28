import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:get/get.dart';

class NavigationDrawer extends StatelessWidget {
  final UserModelController uc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uc.getUser().username,
                  style: const TextStyle(fontSize: 30, color: Colors.amber),
                ),
                Text(uc.getUser().email),
                const SizedBox(
                  height: 20,
                ),
                const Text('Participated in : 10 quizzes'),
              ],
            ),
          ),
          ListTile(
            title: const Text('Quizzes'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('My participations'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
