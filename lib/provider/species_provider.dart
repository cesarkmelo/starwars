import 'package:flutter/material.dart';
import 'package:starwars/models/specie.dart';
import 'package:starwars/services/sw_api.dart';

class SpeciesProvider with ChangeNotifier {
  final List<Specie> _species = [];

  List<Specie> get species {
    return [..._species];
  }

  Future<void> setSpecie(String url) async {
    final existingSpecie = _species.where((specie) => specie.url == url);

    if (existingSpecie.isEmpty) {
      var data = await SwApi().getDataPerson(url);
      Specie specie = specieFromJson(data);
      _species.add(specie);
      notifyListeners();
    }
  }
}
