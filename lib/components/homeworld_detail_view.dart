import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/planet.dart';
import 'package:starwars/provider/planet_provider.dart';
import '../constants.dart';
import 'list_divider.dart';

class HomeworldDetailView extends StatelessWidget {
  final String homeworldUrl;

  const HomeworldDetailView({Key? key, required this.homeworldUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanetsProvider>(
      builder: (context, planetProvider, child) {
        if (homeworldUrl.isEmpty) {
          return const SizedBox.shrink();
        }

        Planet? homeworld;
        try {
          homeworld = planetProvider.planets.firstWhere(
            (p) => p.url == homeworldUrl,
          );
        } on StateError {
          // Element not found, homeworld remains null
          homeworld = null;
        }

        if (homeworld != null) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  homeworld.name,
                  style: kStyleLightGray,
                ),
                // subtitle: Text(
                //   "Population: ${homeworld.population}, Climate: ${homeworld.climate}",
                //   style: kStyleVeryLightGray,
                // ),
              ),
              const ListDivider(),
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
