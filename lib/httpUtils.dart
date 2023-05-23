import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'classes/form.dart';

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
      'Accept': 'application/json'
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

  static void clearAccessToken() {
    document.cookie = "access_token=; path=/";
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

  static Future<int> delete(String endpoint) async {
    Uri uri = Uri.parse(baseUrl + endpoint);
    var request = http.Request('DELETE', uri);
    request.headers.addAll(_getBasicHeaders());

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static Future<int> postWithBody(String endpoint, Map<String, dynamic> body) async {
    var request = http.Request('POST', Uri.parse(baseUrl + endpoint));
    request.body = json.encode(body);
    request.headers.addAll(_getBasicHeaders());
    request.headers['Content-Type'] = 'application/json';
    print(request.body);
    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static Future<int> incrementPosition(String id) async {
    var request = http.Request('POST', Uri.parse('$baseUrl/routes/increment_position?route_id=$id'));

    request.headers.addAll(_getBasicHeaders());

    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static Future<http.StreamedResponse> httpPost(String uri, Map<String, dynamic> body) async {
    var request = http.Request('POST', Uri.parse(uri));
    request.body = json.encode(body);
    request.headers.addAll(_getBasicHeaders());
    request.headers['Content-Type'] = 'application/json';
    http.StreamedResponse response = await request.send();
    return response;
  }

  static Future<double> sendForm(MyForm form) async {
    final best_route_response = await httpPost('$baseUrl/packages/get_best_route', form.toJson());
    if (best_route_response.statusCode == 400) {
      return -1;
    }
    final price_response = await httpPost('$baseUrl/packages/calculate_price', form.toJson());
    String data = await price_response.stream.transform(utf8.decoder).join();
    if (price_response.statusCode == 200) {
      final price = double.parse(data);
      return price;
    }
    return -1;
  }
}