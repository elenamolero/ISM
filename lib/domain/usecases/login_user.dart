import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user.dart' as user;

class LoginUser {
  final SupabaseClient _client = Supabase.instance.client;

  Future<bool> call(user.User user) async {
    try {
      print('Inicio de la consulta para login con email: ${user.email}');

      final response = await _client
          .from('User') 
          .select('email, password')
          .eq('email', user.email)
          .eq('password', user.password)
          .maybeSingle(); // Recupera un solo registro o null

      print('Respuesta de la base de datos: $response');

      if (response == null) {
        print('Usuario no encontrado');
        return false; // Usuario no encontrado
      }
      
      // Si la respuesta no es null, el usuario fue encontrado
      print('Usuario encontrado');
      return true;
    } catch (e) {
      print('Error en la consulta de login: $e');
      return false; // Error en la consulta
    }
  }
}
