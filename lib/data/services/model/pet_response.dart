import 'package:supabase_flutter/supabase_flutter.dart';

class PetResponse {
  final int id;
  final String name;
  final String ownerEmail;
  final int age;
  final String type;
  final String breed;
  final String? photo;
  final bool? nfcConnection;

  PetResponse({
    required this.id,
    required this.name,
    required this.ownerEmail,
    required this.age,
    required this.type,
    required this.breed,
    this.photo,
    this.nfcConnection,
  });

  Future<void> savePetData(PetResponse pet) async {
    await Supabase.instance.client
        .from('Pet') // Fixed table name to match fetchPetsData
        .insert(pet); // Insert the PetResponse objects directly
  }

  Future<void> updatePetData(PetResponse pet) async {
    try {
      print('Attempting to update pet with ID: ${pet.id}');
      print('Update data: ${pet.toMap()}');

      final response = await Supabase.instance.client
          .from('Pet')
          .update({'name': 'marujitas', 'age': 5}).eq('id', pet.id);

      if (response.error != null) {
        print('Supabase update error: ${response.error!.message}');
        throw Exception('Failed to update pet: ${response.error!.message}');
      } else {
        print('Pet updated successfully. Response: ${response.data}');
      }
    } catch (error) {
      print('Error updating pet data: $error');
      throw Exception('Failed to update pet: $error');
    }
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
      nfcConnection: map['nfcConnection'],

    );
  }

  // Convert PetResponse instance to a Map for insertion into Supabase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'type': type,
      'breed': breed,
      'ownerEmail': ownerEmail,
      'photo': photo,
      'nfcConnection': nfcConnection,
    };
  }
}
