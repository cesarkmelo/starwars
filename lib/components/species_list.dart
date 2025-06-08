import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/specie.dart'; // Import Specie model
import 'package:starwars/provider/species_provider.dart';
import '../constants.dart';
import 'list_divider.dart';

class SpeciesList extends StatelessWidget {
  final List<String> speciesUrls; // These are URLs

  const SpeciesList({Key? key, required this.speciesUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeciesProvider>(
      builder: (context, speciesProvider, child) {
        if (speciesUrls.isEmpty) {
          return const SizedBox.shrink();
        }

        List<Widget> speciesWidgets = [];
        for (String url in speciesUrls) {
          final Specie? specie = speciesProvider.species.firstWhere(
            (s) => s.url == url,
            orElse: () => null,
          );

          if (specie != null) {
            speciesWidgets.add(
              Column(
                children: [
                  ListTile(
                    title: Text(
                      specie.name,
                      style: kStyleLightGray,
                    ),
                    // Optionally, display more specie details like classification, language, etc.
                    // subtitle: Text(
                    //   "${specie.classification}, Language: ${specie.language}",
                    //   style: kStyleVeryLightGray,
                    // ),
                  ),
                  const ListDivider(),
                ],
              ),
            );
          } else {
            speciesWidgets.add(
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'Loading species data...',
                      style: kStyleLightGray.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                  const ListDivider(),
                ],
              ),
            );
          }
        }

        if (speciesWidgets.isEmpty && speciesUrls.isNotEmpty) {
             return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("Loading species details...", style: kStyleLightGray)),
             );
        }

        return Column(children: speciesWidgets);
      },
    );
  }
}
