// To parse this JSON data, do
//
//     final payload = payloadFromJson(jsonString);

import 'dart:convert';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  Payload({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic previous;
  List<Person> results;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Person>.from(json["results"].map((x) => Person.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  Person({
    required this.name,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.homeworld,
    required this.species,
    required this.vehicles,
    required this.url,
  });

  String name;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String homeworld;
  List<String> species;
  List<String> vehicles;
  String url;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["name"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        homeworld: json["homeworld"],
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "homeworld": homeworld,
        "species": List<dynamic>.from(species.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
        "url": url,
      };
}
