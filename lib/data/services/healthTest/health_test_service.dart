class HealthTestResponse {
  final int id;
  final String testName;
  final String description;
  final DateTime date;
  final int vetId;
  final int petId;
  final String place;

  HealthTestResponse({
    required this.id,
      required this.testName,
      required this.description,
      required this.date,
      required this.vetId,
      required this.petId,
      required this.place
  });

  // Convert a map to a HealthTestResponse instance
  static HealthTestResponse toDomain(Map<String, dynamic> map) {
    return HealthTestResponse(
      id: map['id'] ?? 0,
      testName: map['testName'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      vetId: map['vetId'] ?? 0,
      petId: map['petId'] ?? 0,
      place: map['place'] ?? '',
    );
  }
}