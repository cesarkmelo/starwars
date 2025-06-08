import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Custom Exception for HTTP errors
class HttpException implements Exception {
  final String message;
  final int statusCode;
  final Uri? uri;

  HttpException({required this.message, required this.statusCode, this.uri});

  @override
  String toString() {
    return 'HttpException: $statusCode $message (URI: $uri)';
  }
}

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<String> getData() async { // Changed return type to Future<String>
    Uri netUrl = Uri.parse(url);
    try {
      http.Response response = await http.get(netUrl);
      if (response.statusCode == 200) {
        // http.Response.body handles decoding to String (defaults to UTF-8)
        // Using response.body is generally simpler unless specific encoding issues exist.
        // For this task, we'll keep the Utf8Decoder for consistency with original code,
        // but acknowledge that response.body is often sufficient.
        var data = const Utf8Decoder().convert(response.bodyBytes);
        return data;
      } else {
        if (kDebugMode) {
          print('Server response code: ${response.statusCode} for URL: $netUrl');
        }
        // Throw an exception for bad responses
        throw HttpException(
          message: 'Request failed with status: ${response.statusCode}.',
          statusCode: response.statusCode,
          uri: netUrl,
        );
      }
    } catch (e) {
      // If it's already an HttpException, or another known type, rethrow.
      // Otherwise, wrap it or handle it as a generic error.
      // For now, rethrowing will propagate network errors or our HttpException.
      if (kDebugMode && e is! HttpException) {
        print('NetworkHelper error for URL $netUrl: $e');
      }
      rethrow;
    }
  }

  // getDataPerson method is removed.
}
