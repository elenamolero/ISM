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