class Character {
  final int id;
  final String image;
  final String name;
  final String species;
  final String gender;
  final String locationName;
  final String status;

  Character({
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.gender,
    required this.locationName,
    required this.status,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final location = (json['location'] as Map?) ?? {};
    return Character(
      id: json['id'] as int,
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? 'unknown',
      species: json['species'] as String? ?? 'unknown',
      gender: json['gender'] as String? ?? 'unknown',
      locationName: location['name'] as String? ?? 'unknown',
      status: json['status'] as String? ?? 'unknown',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'species': species,
    'gender': gender,
    'location': {'name': locationName},
    'status': status,
  };
}
