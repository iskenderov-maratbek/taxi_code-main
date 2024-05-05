import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpRequestService {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print('===============================================');
        print(response.body);
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

getPlaces(query, uri) async {
  String? response = await HttpRequestService.fetchUrl(uri);
}
