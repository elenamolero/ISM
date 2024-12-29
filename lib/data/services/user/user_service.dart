import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:petuco/domain/entities/user.entity.dart' as user;
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
    .update({ 'name': user.name, 'email': user.email, 'address': user.address, 'phoneNumber': user.phoneNumber, 'password': user.password, 'company': user.company, 'cif': user.cif }) 
    .eq('email', user.email)
    .select();
    Supabase.instance.client.auth.updateUser(UserAttributes(password: user.password, email: user.email));
  }

  Future<void> registerUserInfo(user.User user) async {
    try {

      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: user.email,
        password: user.password,
        data: {'role': user.role},
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

 
  Future<void> loginUser(user.User user) async {
    await Supabase.instance.client.auth.signInWithPassword(password: user.password, email: user.email);
  }

  Future<void> logoutUser() async {
    await Supabase.instance.client.auth.signOut();
    print('User logged out');
    print(Supabase.instance.client.auth.currentUser ?? 'User logged out');
  }
  
}