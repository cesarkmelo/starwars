// To parse this JSON data, do
//
//     final planet = planetFromJson(jsonString);

import 'dart:convert';

Planet planetFromJson(String str) => Planet.fromJson(json.decode(str));

String planetToJson(Planet data) => json.encode(data.toJson());

class Planet {
  Planet({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
