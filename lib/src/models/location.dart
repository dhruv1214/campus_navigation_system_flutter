import 'building.dart';

class Location {
  final String roomNumber;
  final String locationId;
  final String name;
  final String description;
  final int floor;
  final String buildingId;
  final int id;
  final List<String> labels;
  final Building? building;

  Location({
    required this.roomNumber,
    required this.locationId,
    required this.name,
    required this.description,
    required this.floor,
    required this.buildingId,
    required this.id,
    required this.labels,
    required this.building,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    if (json['building'] != null) {
      return Location(
        roomNumber: json['roomNumber'],
        locationId: json['locationId'],
        name: json['name'],
        description: json['description'],
        floor: json['floor'],
        buildingId: json['buildingId'],
        id: json['id'],
        labels: List<String>.from(json['labels']),
        building: Building.fromJson(json['building']),
      );
    }

    return Location(
      roomNumber: json['roomNumber'],
      locationId: json['locationId'],
      name: json['name'],
      description: json['description'],
      floor: json['floor'],
      buildingId: json['buildingId'],
      id: json['id'],
      labels: List<String>.from(json['labels']),
      building: null,
    );
  }
}
