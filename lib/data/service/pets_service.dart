import 'package:flutter/material.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetsService {

  Future<List<Pet>> fetchPetsData() async {
  try {
    final response = await Supabase.instance.client.from('Pet').select();
    debugPrint('Response from Supabase: $response'); // Muestra la respuesta completa
    // Verifica si la respuesta tiene datos y luego mapea
    if (response != null && response.isNotEmpty) {
      return response.map<Pet>((pet) {
          return Pet(
            name: pet['name'],
            ownerEmail: pet['ownerEmail'],
            age: pet['age'],
            type: pet['type'],
            breed: pet['breed'],
          );
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