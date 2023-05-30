// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:personalassistant/Image_AI/api_key.dart';

class Api {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");
  static final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apikey"
  };
  static generateImage(String text, String size) async {
    var res = await http.post(url,
        headers: headers,
        body: jsonEncode({"prompt": text, "n": 1, "size": size}));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    } else {
      print("Failed to fethch data");
    }
  }
}
