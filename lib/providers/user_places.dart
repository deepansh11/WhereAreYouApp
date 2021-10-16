import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation placeLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        placeLocation.latitude, placeLocation.longitude);
    final updateAddress = PlaceLocation(address,
        latitude: placeLocation.latitude, longitude: placeLocation.longitude);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updateAddress);

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
              e['address'],
              latitude: e['loc_lat'],
              longitude: e['loc_lng'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
