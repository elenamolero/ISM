class HealthTest {
  final int id;
  final String testName;
  final String description;
  final DateTime date;
  final int vetId;
  final int petId;
  final String place;


  HealthTest(
      {required this.id,
      required this.testName,
      required this.description,
      required this.date,
      required this.vetId,
      required this.petId,
      required this.place
      
      });
}