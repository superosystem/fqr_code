import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:moslem/app/data/models/quran/ayah.dart';

void main() {
  test('should call surah api endpoint', () async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah');
    var res = await http.get(url);
    var data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    expect(res.statusCode, 200);
    expect(data, isNot(null));

  });

  test('should call ayah api endpoint', () async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah/114');
    var req = await http.get(url);
    var body = (json.decode(req.body) as Map<String, dynamic>)["data"];
     Ayah annas = Ayah.fromJson(body);

    expect(body, isNot(null));
    expect(annas.number, 114);
  });
}

