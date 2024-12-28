import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart'
    as path; // Ensure 'path' is added to pubspec.yaml

class PetsService {
  Future<List<PetResponse>> fetchPetsData(String ownerEmail) async {
    try {
      final response = await Supabase.instance.client
          .from('Pet')
          .select('*')
          .eq('ownerEmail', ownerEmail);
      debugPrint('Response from Supabase: $response');

      if (response.isNotEmpty) {
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

  Future<String> uploadImage(File photo) async {
    final fileName =
        '${DateTime.now().toIso8601String()}_${path.basename(photo.path)}';
    await Supabase.instance.client.storage
        .from('petUCOFotos')
        .upload(fileName, photo);

    final photoUrl = Supabase.instance.client.storage
        .from('petUCOFotos')
        .getPublicUrl(fileName);

    return photoUrl;
  }

  Future<void> savePetData(PetResponse pet) async {
    try {
      // Convert the PetResponse object to a Map before inserting
      await Supabase.instance.client
          .from('Pet')
          .insert(pet.toMap()); // Call toMap() to serialize the object
      debugPrint('Save response from Supabase');
    } catch (error) {
      debugPrint('Error saving pet data: $error');
    }
  }

  Future<void> updatePetData(PetResponse pet) async {
    // Perform the update operation
    await Supabase.instance.client
        .from('Pet')
        .update(pet.toMap())
        .eq('id', pet.id)
        .select();
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

      if (response.isNotEmpty) {
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


