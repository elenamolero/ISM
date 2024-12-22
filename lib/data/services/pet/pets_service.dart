import 'package:supabase_flutter/supabase_flutter.dart';

class PetResponse {
  final int id;
  final String name;
  final String ownerEmail;
  final int age;
  final String type;
  final String breed;
  final String? photo;

  PetResponse({
    required this.id,
    required this.name,
    required this.ownerEmail,
    required this.age,
    required this.type,
    required this.breed,
    this.photo,
  });

  Future<void> savePetData(PetResponse pet) async {
    await Supabase.instance.client
        .from('Pet') // Fixed table name to match fetchPetsData
        .insert(pet); // Insert the PetResponse objects directly
  }

  // Convert a map to a PetResponse instance
  static PetResponse toDomain(Map<String, dynamic> map) {
    return PetResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      ownerEmail: map['ownerEmail'] ?? '',
      age: map['age'] ?? 0,
      type: map['type'] ?? '',
      breed: map['breed'] ?? '',
      photo: map['photo'],
    );
  }

  // Convert PetResponse instance to a Map for insertion into Supabase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ownerEmail': ownerEmail,
      'age': age,
      'type': type,
      'breed': breed,
      'photo': photo,
    };
  }
}
