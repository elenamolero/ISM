import 'package:flutter/material.dart';
import 'package:petuco/data/services/healthTest/health_test_service.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/domain/entities/pet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/data/services/model/pet_response.dart'; 

class HealthTestsService {

  Future<List<HealthTestResponse>> fetchHealthTestsData(int petId) async {
    try {
      final response = await Supabase.instance.client.from('HealthTest').select('*').eq('petId', petId);
      debugPrint('Response from Supabase: $response'); 

      if (response != null && response.isNotEmpty) {
        return response.map<HealthTestResponse>((healthTest) {
          return HealthTestResponse.toDomain(healthTest);
        }).toList();
      } else {
        debugPrint('No healthTests found in response');
        return [];
      }
    } catch (error) {
      debugPrint('Error fetching healthTests: $error');  
      return [];
    }
  }
}
