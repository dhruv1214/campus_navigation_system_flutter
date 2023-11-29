import 'package:campus_navigation_system/src/models/location.dart';

class Event{
  final String eventId;
  final String name;
  final String description;
  final String startDateTime;
  final String endDateTime;
  final Location location;

  Event({
    required this.eventId,
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
  });

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    print(json['location']);
    return Event(
      eventId: json['eventId'],
      name: json['name'],
      description: json['description'],
      startDateTime: json['startDateTime'],
      endDateTime: json['endDateTime'],
      location: Location.fromJson(json['location']),
    );
  }
}