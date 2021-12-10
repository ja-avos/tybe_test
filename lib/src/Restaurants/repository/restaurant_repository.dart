import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:tyba_test/src/Restaurants/models/restaurant_model.dart';

class RestaurantRepository {
  static const String _baseSearchUrl =
      "https://api.tomtom.com/search/2/nearbySearch/.JSON?key=YEiSUz39fddTfF1R61uleAHl7VNrhN9O";

  static const String _baseGeocodingUrl =
      "https://api.tomtom.com/search/2/geocode/";

  Future<List<Restaurant>> getRestaurants(String location) async {
    try {
      final query = Uri.encodeQueryComponent(location);
      final url =
          "$_baseGeocodingUrl$query.json?key=YEiSUz39fddTfF1R61uleAHl7VNrhN9O";
      final responseCity = await get(Uri.parse(url));
      final city = jsonDecode(responseCity.body)['results'][0]['position'];
      final lat = city['lat'];
      final lon = city['lon'];
      final restUrl = "$_baseSearchUrl&lat=$lat&lon=$lon&categorySet=7315";
      final response = await get(Uri.parse(restUrl));
      final resJson = jsonDecode(response.body);
      final restaurants = resJson['results'];
      final restaurantList = restaurants.map<Restaurant>((restaurant) {
        return Restaurant.fromJson(restaurant);
      }).toList();
      return restaurantList;
    } catch (e) {
      log("Error getting restaurants: $e");
      rethrow;
    }
  }

  Future<List<Restaurant>> getRestaurantsGPS(double lat, double lng) async {
    return [];
  }
}
