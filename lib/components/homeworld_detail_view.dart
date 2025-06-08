import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/planet.dart'; // Import Planet model
import 'package:starwars/provider/planet_provider.dart';
import '../constants.dart';
import 'list_divider.dart'; // For consistency, though might not be needed if it's a single item

class HomeworldDetailView extends StatelessWidget {
  final String homeworldUrl; // This is a URL

  const HomeworldDetailView({Key? key, required this.homeworldUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanetsProvider>(
      builder: (context, planetProvider, child) {
        if (homeworldUrl.isEmpty) {
          return const SizedBox.shrink();
        }

        final Planet? homeworld = planetProvider.planets.firstWhere(
          (p) => p.url == homeworldUrl,
          orElse: () => null,
        );

        if (homeworld != null) {
          return Column( // Wrap in Column for ListDivider if needed, or just ListTile
            children: [
              ListTile(
                title: Text(
                  homeworld.name,
                  style: kStyleLightGray,
                ),
                // Optionally, display more planet details like population, climate, etc.
                // subtitle: Text(
                //   "Population: ${homeworld.population}, Climate: ${homeworld.climate}",
                //   style: kStyleVeryLightGray,
                // ),
              ),
              const ListDivider(), // Add a divider if it's part of a list
            ],
          );
        } else {
          return Column(
            children: [
              ListTile(
                title: Text(
                  'Loading homeworld data...',
                  style: kStyleLightGray.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              const ListDivider(),
            ],
          );
        }
      },
    );
  }
}
