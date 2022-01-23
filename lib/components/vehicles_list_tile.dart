import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/components/loading_more.dart';
import 'package:starwars/provider/vehicle_provider.dart';

import '../constants.dart';
import 'list_divider.dart';

class VehiclesList extends StatefulWidget {
  final List<String> vehicles;

  const VehiclesList({Key? key, required this.vehicles}) : super(key: key);

  @override
  State<VehiclesList> createState() => _VehiclesListState();
}

class _VehiclesListState extends State<VehiclesList> {
  Future<List<String>> _getVehicles(vehicles) async {
    List<String> vehicleNames = [];
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    vehicles.forEach((vehicleUrl) async {
      await vehicleProvider.setVehicle(vehicleUrl);
      final resultVehicle = vehicleProvider.vehicles
          .where((vehicle) => vehicle.url == vehicleUrl);
      vehicleNames.add(resultVehicle.first.name);
    });
    return vehicleNames;
  }

  @override
  Widget build(BuildContext context) {
    List<String> vehicleNames = [];

    return FutureBuilder(
      future: _getVehicles(widget.vehicles),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          vehicleNames = snapshot.data;
          return Column(
            children: [
              ...vehicleNames
                  .map(
                    (vehicle) => Column(
                      children: [
                        ListTile(
                          title: Text(
                            vehicle,
                            style: kStyleLightGray,
                          ),
                        ),
                        const ListDivider()
                      ],
                    ),
                  )
                  .toList()
            ],
          );
        } else {
          return const SizedBox(
            height: 49,
            child: LoadingMore(),
          );
        }
      },
    );
  }
}
