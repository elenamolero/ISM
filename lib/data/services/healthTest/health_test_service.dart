import 'package:flutter/material.dart';
import 'package:petuco/data/services/model/health_test_response.dart';
import 'package:petuco/domain/entities/healthTest.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 

class HealthTestsService {

  Future<List<HealthTestResponse>> fetchHealthTestsData(int petId) async {
    try {
      final response = await Supabase.instance.client.from('HealthTest').select('*').eq('petId', petId);
      debugPrint('Response from Supabase: $response'); 

      if (response.isNotEmpty) {
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
      await Supabase.instance.client.from('HealthTest').insert(healthTest.toMap());
    } catch (e) {
      throw Exception('Failed to save healthTest info: $e');
    }
  }
}