import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/components/appbar_main.dart';
import 'package:starwars/components/list_divider.dart';
import 'package:starwars/components/loading_error.dart';
import 'package:starwars/components/loading_more.dart';
import 'package:starwars/components/person_detail_list_tile.dart';
import 'package:starwars/components/vehicles_list_tile.dart';
import 'package:starwars/components/species_list.dart';
import 'package:starwars/components/homeworld_detail_view.dart';
import 'package:starwars/extensions/string_ext.dart';
import 'package:starwars/models/payload_people.dart';
import 'package:starwars/services/sw_api.dart'; // SwApi is updated
import 'package:starwars/provider/vehicle_provider.dart';
import 'package:starwars/provider/species_provider.dart';
import 'package:starwars/provider/planet_provider.dart';
// Ensure HttpException is available if specific catch is needed, though not required here
// import 'package:starwars/services/networking.dart';


import '../constants.dart';

class PersonDetailScreen extends StatefulWidget {
  static const routeName = '/person-detail';
  const PersonDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  Person? _person;
  bool _isLoading = true;
  String? _error;
  String? _personUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final url = ModalRoute.of(context)!.settings.arguments as String?;
    if (url != null && url != _personUrl) {
      _personUrl = url;
      _fetchPersonDetails();
    }
  }

  Future<void> _fetchPersonDetails() async {
    if (_personUrl == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _person = null;
    });

    try {
      final swApi = Provider.of<SwApi>(context, listen: false);
      // Use the new method: getDataByFullUrl
      final data = await swApi.getDataByFullUrl(_personUrl!);
      final personData = personFromJson(data); // This function parses the string data

      setState(() {
        _person = personData;
        _isLoading = false;
      });

      _fetchRelatedData(personData);

    } catch (e) { // This will catch HttpException as well
      setState(() {
        _error = e.toString(); // HttpException.toString() gives a good message
        _isLoading = false;
      });
    }
  }

  void _fetchRelatedData(Person person) {
    if (person.vehicles.isNotEmpty) {
      final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
      for (String url in person.vehicles) {
        vehicleProvider.setVehicle(url);
      }
    }

    if (person.species.isNotEmpty) {
      final speciesProvider = Provider.of<SpeciesProvider>(context, listen: false);
      for (String url in person.species) {
        speciesProvider.setSpecie(url);
      }
    }

    if (person.homeworld.isNotEmpty) {
      final planetProvider = Provider.of<PlanetsProvider>(context, listen: false);
      planetProvider.setPlanet(person.homeworld);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_isLoading) {
      bodyContent = const LoadingMore();
    } else if (_error != null) {
      bodyContent = LoadingError(message: _error, onRefresh: _fetchPersonDetails);
    } else if (_person != null) {
      bodyContent = PersonInfo(swPerson: _person!);
    } else {
      bodyContent = const Text('No person data found.');
    }

    return Scaffold(
      appBar: AppBarMain(title: _person?.name ?? 'Person Detail'),
      body: bodyContent,
    );
  }
}

class PersonInfo extends StatelessWidget {
  const PersonInfo({
    Key? key,
    required this.swPerson,
  }) : super(key: key);

  final Person swPerson;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('General information'),
          DetailPersonListTile(
            label: 'Eye Color',
            value: swPerson.eyeColor.capitalize(),
          ),
          const ListDivider(),
          DetailPersonListTile(
            label: 'Hair Color',
            value: swPerson.hairColor.capitalize(),
          ),
          const ListDivider(),
          DetailPersonListTile(
            label: 'Skin Color',
            value: swPerson.skinColor.capitalize(),
          ),
          const ListDivider(),
          DetailPersonListTile(
            label: 'Birth Year',
            value: swPerson.birthYear,
          ),
          const ListDivider(),

          if (swPerson.homeworld.isNotEmpty) ...[
            _buildSectionTitle('Homeworld'),
            HomeworldDetailView(homeworldUrl: swPerson.homeworld),
          ],

          if (swPerson.species.isNotEmpty) ...[
            _buildSectionTitle('Species'),
            SpeciesList(speciesUrls: swPerson.species),
          ],

          if (swPerson.vehicles.isNotEmpty) ...[
            _buildSectionTitle('Vehicles'),
            VehiclesList(vehicles: swPerson.vehicles),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: kTitlePadding,
      child: Text(
        title,
        style: kStyleDarkGray,
      ),
    );
  }
}
