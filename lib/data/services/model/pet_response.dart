import 'package:flutter/material.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/data/services/model/pet_response.dart'; // Import the PetResponse model

class PetsService {

  Future<List<PetResponse>> fetchPetsData(String ownerEmail) async {
    try {
      final response = await Supabase.instance.client.from('Pet').select('*').eq('ownerEmail', ownerEmail);
      debugPrint('Response from Supabase: $response'); // Muestra la respuesta completa

      // Verifica si la respuesta tiene datos y luego mapea
      if (response != null && response.isNotEmpty) {
        return response.map<PetResponse>((pet) {
          return PetResponse.toDomain(pet);
        }).toList();
      } else {
        debugPrint('No pets found in response');
        return [];
      }
    } catch (error) {
      debugPrint('Error fetching pets: $error');  // Muestra el error
      return [];
    }
  }
}
