import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/domain/entities/user.dart' as user;
import 'package:petuco/data/services/model/user_response.dart' as user_response;

class UserService {
  Future<user_response.UserResponse?> getUserInfo(String email) async {

    Map<String, dynamic>? dataFromApi = await Supabase.instance.client
      .from('User')
      .select()
      .eq('email', email)
      .maybeSingle();

    if (dataFromApi == null) {
      return null;
    } else {
      return user_response.UserResponse.toDomain(dataFromApi);
    }
  }

  Future<void> saveUserInfo(user.User user) async {
    await Supabase.instance.client.from('User')
    .update({ 'name': user.name, 'email': user.email, 'address': user.address, 'phoneNumber': user.phoneNumber, 'password': user.password}) 
    .eq('email', user.email)
    .select();
  }

  Future<void> registerUserInfo(user.User user) async {
    try {

      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: user.email,
        password: user.password,
      );

      if (res.user != null) {
          await Supabase.instance.client.from('User').insert({
          'name': user.name,
          'email': user.email,
          'address': user.address,
          'phoneNumber': user.phoneNumber,
          'password': user.password,
          'role': user.role,
          'company': user.company,
          'cif': user.cif,
        });

        print('User registered and data inserted successfully');
      } 
    } catch (e) {
      print('Error during user registration: $e');
      rethrow; 
    }
  }

  Future<bool> loginUser(user.User user) async {
    final response = await Supabase.instance.client
        .from('User') 
        .select('email, password')
        .eq('email', user.email)
        .eq('password', user.password)
        .maybeSingle();
    if (response == null) {
      return false; 
    }
    return true;
  }

  
}