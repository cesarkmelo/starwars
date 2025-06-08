import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/pages/home.dart';
import 'package:starwars/pages/person_detail.dart';
import 'package:starwars/pallete.dart';
import 'package:starwars/provider/people_provider.dart'; // Import PeopleProvider
import 'package:starwars/provider/planet_provider.dart';
import 'package:starwars/provider/species_provider.dart';
import 'package:starwars/provider/vehicle_provider.dart';
import 'package:starwars/services/sw_api.dart'; // Import SwApi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider for SwApi itself, making it available to other providers
        Provider<SwApi>(create: (_) => SwApi()),

        // ChangeNotifierProxyProvider for PeopleProvider
        ChangeNotifierProxyProvider<SwApi, PeopleProvider>(
          create: (context) => PeopleProvider(Provider.of<SwApi>(context, listen: false)),
          update: (context, swApi, previousPeopleProvider) =>
              PeopleProvider(swApi), // Pass SwApi to PeopleProvider
        ),

        // ChangeNotifierProxyProvider for PlanetsProvider
        ChangeNotifierProxyProvider<SwApi, PlanetsProvider>(
          create: (context) => PlanetsProvider(Provider.of<SwApi>(context, listen: false)),
          update: (context, swApi, previousPlanetsProvider) =>
              PlanetsProvider(swApi), // Pass SwApi to PlanetsProvider
        ),

        // ChangeNotifierProxyProvider for SpeciesProvider
        ChangeNotifierProxyProvider<SwApi, SpeciesProvider>(
          create: (context) => SpeciesProvider(Provider.of<SwApi>(context, listen: false)),
          update: (context, swApi, previousSpeciesProvider) =>
              SpeciesProvider(swApi), // Pass SwApi to SpeciesProvider
        ),

        // ChangeNotifierProxyProvider for VehicleProvider
        ChangeNotifierProxyProvider<SwApi, VehicleProvider>(
          create: (context) => VehicleProvider(Provider.of<SwApi>(context, listen: false)),
          update: (context, swApi, previousVehicleProvider) =>
              VehicleProvider(swApi), // Pass SwApi to VehicleProvider
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'People',
        theme: ThemeData(
          primarySwatch: Pallete.starwarspallete,
        ),
        home: const HomePage(),
        routes: {
          PersonDetailScreen.routeName: (ctx) => const PersonDetailScreen(),
        },
      ),
    );
  }
}
