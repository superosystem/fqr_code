import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FQR CODE'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Home is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> result = await authC.logout();
          if (result["error"] == false) {
            Get.offAllNamed(Routes.login);
          } else {
            Get.snackbar("ERROR", result["error"]);
          }
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
