import 'package:flutter/material.dart';
import 'package:starwars/models/planet.dart';
import 'package:starwars/services/sw_api.dart';

class PlanetsProvider with ChangeNotifier {
  final List<Planet> _planets = [];

  List<Planet> get planets {
    return [..._planets];
  }

  Future<void> setPlanet(String url) async {
    final Planet planet;
    final existingPlanet = _planets.where((planet) => planet.url == url);

    if (existingPlanet.isEmpty) {
      var data = await SwApi().getDataPerson(url);
      planet = planetFromJson(data);
      _planets.add(planet);
      notifyListeners();
    }
  }
}
