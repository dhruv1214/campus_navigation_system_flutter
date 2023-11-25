class Path {
      final String locationId;
      final String roomNumber;
      final String name;
      final String description;
      final int floor;
      final String buildingId;
      final int distanceToNext;

      Path({
        required this.locationId,
        required this.roomNumber,
        required this.name,
        required this.description,
        required this.floor,
        required this.buildingId,
        required this.distanceToNext,
      });

      factory Path.fromJson(Map<String, dynamic> json) {
        return Path(
          locationId: json['locationId'],
          roomNumber: json['roomNumber'],
          name: json['name'],
          description: json['description'],
          floor: json['floor'],
          buildingId: json['buildingId'],
          distanceToNext: json['distanceToNext'],
        );
      }


    }
