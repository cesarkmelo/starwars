import 'package:flutter/material.dart';
import 'package:starwars/models/planet.dart';
import 'package:starwars/services/sw_api.dart';

class PlanetsProvider with ChangeNotifier {
  final SwApi _swApi;
  PlanetsProvider(this._swApi);

  final List<Planet> _planets = [];

  List<Planet> get planets {
    return [..._planets];
  }

  Future<void> setPlanet(String url) async {
    final Planet planet;
    // Check if planet with the same URL already exists
    if (_planets.any((p) => p.url == url)) {
      return; // Already exists, no need to fetch again
    }

    // var data = await SwApi().getDataPerson(url); // Old way
    try {
      var data = await _swApi.getDataByFullUrl(url); // Changed to getDataByFullUrl
      planet = planetFromJson(data);
      _planets.add(planet);
      notifyListeners();
    } catch (e) {
      // Handle errors, e.g., print to console or set an error state
      if (kDebugMode) {
        print('Error fetching planet data for $url: $e');
      }
      // Optionally, rethrow or set an error message in the provider
    }
  }
}
