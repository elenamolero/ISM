import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:petuco/domain/entities/user.dart' as user;
import 'package:petuco/data/services/model/user_response.dart' as user_response;

class UserService {
  Future<user_response.UserResponse?> getUserInfo(String email) async {
    Map<String, dynamic>? dataFromApi = await Supabase.instance.client
      .from('User')
      .select()
      .eq('email', email)
      .single();

    return user_response.UserResponse.toDomain(dataFromApi);
  }

  Future<void> saveUserInfo(user.User user) async {
    await Supabase.instance.client.from('User')
    .update({ 'name': user.name, 'email': user.email, 'address': user.address, 'phoneNumber': user.phoneNumber, 'password': user.password}) 
    .eq('email', user.email)
    .select();
  }

  Future<void> loginUser(user.User user) async {
    await Supabase.instance.client.auth.signInWithPassword(password: user.password, email: user.email);
    Supabase.instance.client.auth.setInitialSession(user.email);
  }
}