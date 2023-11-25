class Building {
  final String imageURL;
  final String name;
  final String description;
  final String buildingId;
  final int id;
  final List<String> labels;

  Building({
    required this.imageURL,
    required this.name,
    required this.description,
    required this.buildingId,
    required this.id,
    required this.labels,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      imageURL: json['imageURL'],
      name: json['name'],
      description: json['description'],
      buildingId: json['buildingId'],
      id: json['id'],
      labels: List<String>.from(json['labels']),
    );
  }
}

