import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moslem/app/modules/home/controllers/home_controller.dart';
import 'package:moslem/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Moslem Apps'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Al-Qur\'an"),
            onPressed: () => Get.offAllNamed(Routes.SURAH),
          ),
        ));
  }
}
