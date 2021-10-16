import 'package:flutter/material.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_places.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:places_app/screens/places_list.dart';
import 'package:provider/provider.dart';

//! Packages Used:-
//* 1. Google Maps
//* 2. Image Picker
//* 3. Path Provider
//* 4. Path
//* 5. SQFlite

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaces.routeName: (ctx) => const AddPlaces(),
          PlaceDetails.routeName: (ctx) => const PlaceDetails()
        },
      ),
    );
  }
}
