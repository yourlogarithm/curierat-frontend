import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class HttpUtils {
  static const String baseUrl = "http://127.0.0.1:8000";
  static const String tokenUrl = "/token";
  static const Map<String, String> tokenHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json'
  };

  static Map<String, String> _getBasicHeaders() {
    return {
      'Authorization': 'Bearer ${getAccessToken()}',
    };
  }

  static String? getAccessToken() {
    final cookie = document.cookie!;
    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });
    final cookieMap = Map.fromEntries(entity);
    return cookieMap['access_token'];
  }

  static Future<void> login(String username, String password) async {
    var request = http.Request('POST', Uri.parse(baseUrl + tokenUrl));
    request.bodyFields = {
      'username': username,
      'password': password
    };
    request.headers.addAll(tokenHeaders);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.transform(utf8.decoder).join();
      var json = jsonDecode(body);
      document.cookie = "access_token=${json['access_token']}; path=/";
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  static Future<dynamic> get(String endpoint) async {
    var request = http.Request('GET', Uri.parse(baseUrl + endpoint));
    request.headers.addAll(_getBasicHeaders());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.transform(utf8.decoder).join();
      return jsonDecode(body);
    } else {
      debugPrint(response.reasonPhrase);
      return {};
    }
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    var request = http.Request('POST', Uri.parse(baseUrl + endpoint));
    request.body = json.encode(body);
    request.headers.addAll(_getBasicHeaders());
    http.StreamedResponse response = await request.send();
    String data = await response.stream.transform(utf8.decoder).join();
    if (response.statusCode == 200) {
      return jsonDecode(data);
    }
    else {
      print(jsonDecode(data));
      return {};
    }
  }
}