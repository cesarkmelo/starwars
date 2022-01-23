import 'package:flutter/material.dart';
import 'package:starwars/components/appbar_main.dart';
import 'package:starwars/components/list_divider.dart';
import 'package:starwars/components/loading_error.dart';
import 'package:starwars/components/loading_more.dart';
import 'package:starwars/components/person_detail_list_tile.dart';
import 'package:starwars/components/vehicles_list_tile.dart';
import 'package:starwars/extensions/string_ext.dart';
import 'package:starwars/models/payload_people.dart';
import 'package:starwars/services/sw_api.dart';

import '../constants.dart';

class PersonDetailScreen extends StatelessWidget {
  static const routeName = '/person-detail';
  const PersonDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personUrl = ModalRoute.of(context)!.settings.arguments as String;

    Future<Person> _getPerson() async {
      var data = await SwApi().getDataPerson(personUrl);
      return personFromJson(data);
    }

    return FutureBuilder<dynamic>(
      future: _getPerson(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Person swPerson = snapshot.data;
          return Scaffold(
            appBar: AppBarMain(title: swPerson.name),
            body: PersonInfo(swPerson: swPerson),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            appBar: AppBarMain(title: 'Person'),
            body: LoadingError(),
          );
        } else {
          return const Scaffold(
            appBar: AppBarMain(title: 'Person'),
            body: LoadingMore(),
          );
        }
      },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: kTitlePadding,
          child: Text(
            'General information',
            style: kStyleDarkGray,
          ),
        ),
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
        swPerson.vehicles.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: kTitlePadding,
                    child: Text(
                      'Vehicles',
                      style: kStyleDarkGray,
                    ),
                  ),
                  VehiclesList(vehicles: swPerson.vehicles)
                ],
              )
            : const SizedBox(
                height: 0,
                width: 0,
              )
      ],
    );
  }
}
