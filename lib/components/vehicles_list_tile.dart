import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/vehicle.dart'; // Import the Vehicle model
import 'package:starwars/provider/vehicle_provider.dart';
import '../constants.dart';
import 'list_divider.dart';

class VehiclesList extends StatelessWidget { // Changed to StatelessWidget
  final List<String> vehicles; // These are URLs

  const VehiclesList({Key? key, required this.vehicles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to VehicleProvider changes
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        if (vehicles.isEmpty) {
          return const SizedBox.shrink(); // No vehicle URLs to display
        }

        List<Widget> vehicleWidgets = [];
        for (String url in vehicles) {
          // Find the vehicle in the provider's list
          // This relies on PersonDetailScreen having already called setVehicle for these URLs
          Vehicle? vehicle;
          try {
            vehicle = vehicleProvider.vehicles.firstWhere(
              (v) => v.url == url,
            );
          } on StateError {
            vehicle = null; // Element not found
          }

          if (vehicle != null) {
            vehicleWidgets.add(
              Column(
                children: [
                  ListTile(
                    title: Text(
                      vehicle.name,
                      style: kStyleLightGray,
                    ),
                    // Potentially add more vehicle details here if needed
                  ),
                  const ListDivider(),
                ],
              ),
            );
          } else {
            // Optional: Show a loading indicator or placeholder for this specific vehicle
            // if it's still being fetched or if an error occurred for this specific item.
            // For now, we'll just show the URL or a simple loading text.
            vehicleWidgets.add(
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'Loading vehicle data...', // Or display the URL: url
                      style: kStyleLightGray.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                  const ListDivider(),
                ],
              ),
            );
          }
        }

        if (vehicleWidgets.isEmpty && vehicles.isNotEmpty) {
          // This case might happen if none of लाई vehicles are loaded yet
          // but PersonDetailScreen is supposed to have triggered their loading.
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("Loading vehicle details...", style: kStyleLightGray)),
          );
        }

        return Column(children: vehicleWidgets);
      },
    );
  }
}
