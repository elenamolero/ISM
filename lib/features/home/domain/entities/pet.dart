//This is the class Pet and all his attributes
class Pet {
  final String name;
  final int ownerID;
  final int age;
  final String type;
  final String breed;

//All required fields from class Pet
  Pet(
      {required this.name,
      required this.ownerID,
      required this.age,
      required this.type,
      required this.breed});
}