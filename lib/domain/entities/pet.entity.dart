//This is the class Pet and all his attributes
class Pet {
  final int id;
  final String name;
  final String ownerEmail;
  final int age;
  final String type;
  final String breed;
  final String? photo;
  final bool? nfcConnection;

//All required fields from class Pet
  Pet(
      {required this.id,
      required this.name,
      required this.ownerEmail,
      required this.age,
      required this.type,
      required this.breed,
      this.photo,
      this.nfcConnection});
}
