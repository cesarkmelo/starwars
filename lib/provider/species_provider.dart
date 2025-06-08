import 'package:flutter/material.dart';
import 'package:starwars/models/specie.dart';
import 'package:starwars/services/sw_api.dart';

class SpeciesProvider with ChangeNotifier {
  final SwApi _swApi;
  SpeciesProvider(this._swApi);

  final List<Specie> _species = [];

  List<Specie> get species {
    return [..._species];
  }

  Future<void> setSpecie(String url) async {
    // Check if specie with the same URL already exists
    if (_species.any((s) => s.url == url)) {
      return; // Already exists, no need to fetch again
    }

    // var data = await SwApi().getDataPerson(url); // Old way
    try {
      var data = await _swApi.getDataByFullUrl(url); // Changed to getDataByFullUrl
      Specie specie = specieFromJson(data);
      _species.add(specie);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching species data for $url: $e');
      }
    }
  }
}
