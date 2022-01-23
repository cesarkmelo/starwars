import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/pages/home.dart';
import 'package:starwars/pages/person_detail.dart';
import 'package:starwars/pallete.dart';
import 'package:starwars/provider/planet_provider.dart';
import 'package:starwars/provider/species_provider.dart';
import 'package:starwars/provider/vehicle_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlanetsProvider()),
        ChangeNotifierProvider(create: (_) => SpeciesProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
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
