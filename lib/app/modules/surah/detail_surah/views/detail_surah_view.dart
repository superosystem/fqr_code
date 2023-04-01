import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moslem/app/data/models/quran/detail_surah.dart' as detail;
import 'package:moslem/app/data/models/quran/surah.dart';
import 'package:moslem/app/modules/surah/detail_surah/controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surah ${surah.name.transliteration.en}"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    surah.name.transliteration.en.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    surah.name.translation.en,
                    style: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${surah.numberOfVerses} Ayah | ${surah.revelation.en}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah?>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Empty"),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data?.verses?.length == 0) {
                    return const SizedBox();
                  }
                  detail.Verse? ayah = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.bookmark_add_outlined),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        ayah!.text.arab,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 28),
                      ),
                      SizedBox(height: 10),
                      Text(
                        ayah!.translation.en,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
