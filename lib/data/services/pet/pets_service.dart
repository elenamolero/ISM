class PetResponse {
  final String name;
  final String ownerEmail;
  final int age;
  final String type;
  final String breed;
  final String? imageUrl;

  PetResponse({
    required this.name,
    required this.ownerEmail,
    required this.age,
    required this.type,
    required this.breed,
    this.imageUrl,
  });

  // Convert a map to a PetResponse instance
  static PetResponse toDomain(Map<String, dynamic> map) {
    return PetResponse(
      name: map['name'] ?? '',
      ownerEmail: map['ownerEmail'] ?? '',
      age: map['age'] ?? 0,
      type: map['type'] ?? '',
      breed: map['breed'] ?? '',
      imageUrl: map['photo'],
    );
  }
}
