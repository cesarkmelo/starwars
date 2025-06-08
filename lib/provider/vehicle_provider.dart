import 'package:flutter/foundation.dart';
import 'package:starwars/models/vehicle.dart';
import 'package:starwars/services/sw_api.dart';

class VehicleProvider with ChangeNotifier {
  final SwApi _swApi;
  VehicleProvider(this._swApi);

  final List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles {
    return [..._vehicles];
  }

  Future<void> setVehicle(String url) async {
    // Check if vehicle with the same URL already exists
    if (_vehicles.any((v) => v.url == url)) {
      return; // Already exists, no need to fetch again
    }
    // var data = await SwApi().getDataPerson(url); // Old way
    try {
      var data =
          await _swApi.getDataByFullUrl(url); // Changed to getDataByFullUrl
      Vehicle vehicle = vehicleFromJson(data);
      _vehicles.add(vehicle);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vehicle data for $url: $e');
      }
    }
  }
}
