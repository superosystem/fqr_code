import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moslem/app/data/models/quran/surah.dart';
import 'package:moslem/app/modules/surah/controllers/surah_controller.dart';
import 'package:moslem/app/routes/app_pages.dart';

class SurahView extends GetView<SurahController> {
  const SurahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Qur\'an'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>?>(
        future: controller.getAllSurah(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "An error occurred in the application. Click me to refresh!",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () => Get.offAllNamed(Routes.HOME),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Surah surah = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${surah.number}"),
                ),
                title: Text(surah.name.transliteration.en),
                subtitle: Text(
                    "${surah.numberOfVerses} Ayah | ${surah.revelation.en}"),
                trailing: Text(surah.name.short),
                onTap: () {
                  Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                },
              );
            },
          );
        },
      ),
    );
  }
}
