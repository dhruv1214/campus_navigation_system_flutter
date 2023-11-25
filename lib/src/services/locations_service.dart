import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/route.dart' as route;

import '../models/location.dart';

class LocationsService {
  static Future<List<Location>> fetchLocations() async {
    try {
      final url = Uri.parse('http://192.168.0.29:8898/api/v1/locations');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonLocations = jsonDecode(response.body);
        return jsonLocations.map((json) => Location.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch locations');
      }
    } catch (e) {
      throw Exception('Failed to fetch locations');
    }
  }

  static Future<List<Location>> fetchLocationsByBuildingId(String buildingId) async {
    try {
      final url =
          Uri.parse('http://192.168.0.29:8898/api/v1/locations/building/$buildingId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonLocations = jsonDecode(response.body);
        return jsonLocations.map((json) => Location.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch locations');
      }
    } catch (e) {
      throw Exception('Failed to fetch locations');
    }
  }


  static Future<route.Route> fetchRoute(String startLocationId, String endLocationId) async {
    try {
      final url = Uri.parse(
          'http://192.168.0.29:8898/api/v1/locations/distance/$startLocationId/$endLocationId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonLocation = jsonDecode(response.body);
        return route.Route.fromJson(jsonLocation);
      } else {
        throw Exception('Failed to fetch route');
      }
    } catch (e) {
      throw Exception('Failed to fetch route');
    }
  }
}
