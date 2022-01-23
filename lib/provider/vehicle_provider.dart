import 'package:flutter/material.dart';
import 'package:starwars/models/vehicle.dart';
import 'package:starwars/services/sw_api.dart';

class VehicleProvider with ChangeNotifier {
  final List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles {
    return [..._vehicles];
  }

  Future<void> setVehicle(String url) async {
    final existingVehicle = _vehicles.where((vehicle) => vehicle.url == url);

    if (existingVehicle.isEmpty) {
      var data = await SwApi().getDataPerson(url);
      Vehicle vehicle = vehicleFromJson(data);
      _vehicles.add(vehicle);
      notifyListeners();
    }
  }
}
