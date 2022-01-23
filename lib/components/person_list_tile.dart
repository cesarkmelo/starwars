import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/payload_people.dart';
import 'package:starwars/models/planet.dart';
import 'package:starwars/models/specie.dart';
import 'package:starwars/provider/planet_provider.dart';
import 'package:starwars/provider/species_provider.dart';

import '../constants.dart';

class PersonListTile extends StatefulWidget {
  final Person person;
  const PersonListTile({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonListTile> createState() => _PersonListTileState();
}

class _PersonListTileState extends State<PersonListTile> {
  late Planet _planet;
  late Specie _specie;
  // Arreglo de specie vacia para humanos en API
  String specieUrl = 'https://swapi.dev/api/species/1/';

  Future<void> getPlanet() async {
    final planetProvider = Provider.of<PlanetsProvider>(context);
    await planetProvider.setPlanet(widget.person.homeworld);
    final resultPlanet = planetProvider.planets
        .where((planet) => planet.url == widget.person.homeworld);
    _planet = resultPlanet.first;
  }

  Future<void> getSpecie() async {
    final specieProvider = Provider.of<SpeciesProvider>(context);
    if (widget.person.species.isNotEmpty) {
      specieUrl = widget.person.species.first;
    }
    await specieProvider.setSpecie(specieUrl);
    final resultSpecie =
        specieProvider.species.where((specie) => specie.url == specieUrl);
    _specie = resultSpecie.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 69,
      child: ListTile(
        title: Text(
          widget.person.name,
          style: kStyleDarkGray,
        ),
        subtitle: FutureBuilder(
            future: Future.wait([getPlanet(), getSpecie()]),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${_specie.name} from ${_planet.name}',
                  style: kStyleLightGraySmall,
                );
              } else {
                return const SizedBox(width: 0, height: 0);
              }
            }),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
