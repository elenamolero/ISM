import 'package:flutter/material.dart';
import 'package:petuco/data/services/healthTest/health_test_service.dart';
import 'package:petuco/data/services/model/health_test_response.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/domain/entities/healthTest.dart';
import 'package:petuco/domain/entity/pet.entity.dart';
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

  Future<void> saveHealthTestInfo(HealthTest healthTest) async {
    try {
      await Supabase.instance.client.from('HealthTest').insert({
        'id': healthTest.id,
        'testName': healthTest.testName,
        'description': healthTest.description,
        'date': healthTest.date,
        'vetId': healthTest.vetId,
        'petId': healthTest.petId,
        'place': healthTest.place,
      });
    } catch (e) {
      print('Error in service while saving healthTest info: $e');
      throw Exception('Failed to save healthTest info: $e');
    }
  }
}