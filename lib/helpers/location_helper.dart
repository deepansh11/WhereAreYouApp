import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const API_KEY = 'AIzaSyAApEGMwTgs4wd8LIRFrTKo36-wESF8eEM';

class LocationHelper {
  static String generateLocationPreview({double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$API_KEY');

    final response = await http.get(url);

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
