import 'package:campus_navigation_system/src/models/path.dart';

class Route {
      final List<Path> path;
      final int totalDistance;

      Route({
        required this.path,
        required this.totalDistance,
      });

      factory Route.fromJson(Map<String, dynamic> json) {
        return Route(
          path: List<Path>.from(json['path'].map((path) => Path.fromJson(path))),
          totalDistance: json['totalDistance'],
        );
      }
    }