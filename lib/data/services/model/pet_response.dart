import 'package:flutter/material.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetsService {
  Future<List<PetResponse>> fetchPetsData(String ownerEmail) async {
    try {
      final response = await Supabase.instance.client
          .from('Pet')
          .select('*')
          .eq('ownerEmail', ownerEmail);
      debugPrint('Response from Supabase: $response');

      if (response != null && response.isNotEmpty) {
        return response.map<PetResponse>((pet) {
          return PetResponse.toDomain(pet);
        }).toList();
      } else {
        debugPrint('No pets found in response');
        return [];
      }
    } catch (error) {
      debugPrint('Error fetching pets: $error');
      return [];
    }
  }

  Future<void> savePetData(PetResponse pet) async {
    try {
      // Convert the PetResponse object to a Map before inserting
      final response = await Supabase.instance.client
          .from('Pet')
          .insert(pet.toMap()); // Call toMap() to serialize the object
      debugPrint('Save response from Supabase: $response');
    } catch (error) {
      debugPrint('Error saving pet data: $error');
    }
  }

  Future<PetResponse?> fetchPetDataById(int petId) async {
    try {
      // Realizar la consulta a la base de datos para obtener un único registro
      final response = await Supabase.instance.client
          .from('Pet')
          .select()
          .eq('id', petId)
          .single(); // single() asegura que solo esperamos un único registro

      debugPrint('Response from Supabase: $response');

      if (response != null) {
        // Convertir la respuesta al dominio PetResponse
        return PetResponse.toDomain(response);
      } else {
        debugPrint('No pet found in response');
        return null;
      }
    } catch (error) {
      debugPrint('Error fetching pet: $error');
      return null;
    }
  }
}
