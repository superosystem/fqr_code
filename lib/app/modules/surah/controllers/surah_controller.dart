import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moslem/app/data/models/quran/surah.dart';
import 'package:moslem/app/data/remote/api_constant.dart';

class SurahController extends GetxController {
  Future<List<Surah>?> getAllSurah() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseQuranApi + ApiConstants.surahEndpoint);
      var res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecodeToDynamic(res.body)["data"];
        return data.map((e) => Surah.fromJson(e)).toList();
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
