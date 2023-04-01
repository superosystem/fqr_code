import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moslem/app/data/models/quran/detail_surah.dart';
import 'package:moslem/app/data/remote/api_constant.dart';

class DetailSurahController extends GetxController {
  Future<DetailSurah?> getDetailSurah(String ayahEndpoint) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseQuranApi}${ApiConstants.surahEndpoint}/$ayahEndpoint");
      var res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecodeToDynamic(res.body)["data"];
        return DetailSurah.fromJson(data);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Map<String, dynamic> jsonDecodeToDynamic(res) {
    return (json.decode(res) as Map<String, dynamic>);
  }
}
