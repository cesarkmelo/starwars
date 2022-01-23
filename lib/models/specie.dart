// To parse this JSON data, do
//
//     final specie = specieFromJson(jsonString);

import 'dart:convert';

Specie specieFromJson(String str) => Specie.fromJson(json.decode(str));

String specieToJson(Specie data) => json.encode(data.toJson());

class Specie {
  Specie({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Specie.fromJson(Map<String, dynamic> json) => Specie(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
