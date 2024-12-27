import 'package:intl/intl.dart';

class HealthTest {
  final String testName;
  final String description;
  final DateTime date;
  final String vetId;
  final int petId;
  final String place;

  HealthTest({
    required this.testName,
    required this.description,
    required this.date,
    required this.vetId,
    required this.petId,
    required this.place,
  });

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

  factory HealthTest.fromMap(Map<String, dynamic> map) {
    return HealthTest(
      testName: map['testName'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] is String ? DateTime.parse(map['date']) : DateTime.now(),
      vetId: map['vetId'] ?? '',
      petId: map['petId'] ?? 0,
      place: map['place'] ?? '',
    );
  }
}

