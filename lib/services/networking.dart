import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Uri netUrl = Uri.parse(url);
    try {
      http.Response response = await http.get(netUrl);
      if (response.statusCode == 200) {
        var data = const Utf8Decoder().convert(response.bodyBytes);
        return data;
      } else {
        if (kDebugMode) {
          print('Codigo de respuesta de servidor ${response.statusCode}');
        }
        var data = {'error': 1};
        return data;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future getDataPerson() async {
    Uri netUrl = Uri.parse(url);
    try {
      http.Response response = await http.get(netUrl);
      if (response.statusCode == 200) {
        var data = const Utf8Decoder().convert(response.bodyBytes);
        return data;
      } else {
        if (kDebugMode) {
          print('Codigo de respuesta de servidor ${response.statusCode}');
        }
        var data = {'error': 1};
        return data;
      }
    } catch (error) {
      rethrow;
    }
  }
}
