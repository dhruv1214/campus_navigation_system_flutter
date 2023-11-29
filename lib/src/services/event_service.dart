import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventService {
  static Future<List<Event>> fetchEvents() async {
    try {
      final url = Uri.parse('http://192.168.0.29:8898/api/v1/events');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonLocations = jsonDecode(response.body);
        print(jsonLocations);
        return jsonLocations.map((json) {
          return Event.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to fetch locations');
      }
    } catch (e) {
      throw Exception('Failed to fetch locations');
    }
  }
}
