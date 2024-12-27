
import 'package:intl/intl.dart';

class HealthTestResponse {
  final String testName;
  final String description;
  final DateTime date;
  final String vetId;
  final int petId;
  final String place;

  HealthTestResponse({
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
      testName: map['testName'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      vetId: map['vetId'] ?? '',
      petId: map['petId'] ?? 0,
      place: map['place'] ?? '',
    );
  }

    // Convert HealthTest to a Map
  Map<String, dynamic> toMap() {
    return {
      'testName': testName,
      'description': description,
      'date': DateFormat('yyyy-MM-ddTHH:mm:ss').format(date),
      'vetId': vetId,
      'petId': petId,
      'place': place,
    };
  }

  // Create a HealthTest from a Map
  factory HealthTestResponse.fromMap(Map<String, dynamic> map) {
    return HealthTestResponse(
      testName: map['testName'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] is String ? DateTime.parse(map['date']) : DateTime.now(),
      vetId: map['vetId'] ?? '',
      petId: map['petId'] ?? 0,
      place: map['place'] ?? '',
    );
  }
}