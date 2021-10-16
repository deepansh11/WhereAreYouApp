import 'package:flutter/material.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_places.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaces.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserPlaces>(
                    builder: (BuildContext context, value, child) => value
                            .items.isEmpty
                        ? child!
                        : ListView.builder(
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(value.items[i].image),
                              ),
                              title: Text(value.items[i].title),
                              subtitle: Text(value.items[i].location!.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetails.routeName,
                                    arguments: value.items[i].id);
                              },
                            ),
                            itemCount: value.items.length,
                          ),
                    child: const Center(
                      child: Text('Got no places, please add some'),
                    ),
                  ),
      ),
    );
  }
}
