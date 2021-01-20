import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Network {
  static Future<Map<String, dynamic>> callAPI(
      {@required String url,
      @required NetworkAction networkAction,
      Map<String, dynamic> payload,
      String token = ""}) async {
    Response response;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token
    };
    if (networkAction == NetworkAction.GET) {
      response = await get(url, headers: header);
    } else if (networkAction == NetworkAction.POST) {
      response = await post(url, headers: header, body: jsonEncode(payload));
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return null;
    }
  }
}

enum NetworkAction { GET, POST }
