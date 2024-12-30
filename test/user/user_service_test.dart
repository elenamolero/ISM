/*import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:supabase/supabase.dart';
import 'package:petuco/domain/entities/user.entity.dart' as user;

import 'user_service_test.mocks.dart';

@GenerateMocks([SupabaseClient, SupabaseQueryBuilder])
void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late UserService userService;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    userService = UserService();

    when(mockSupabaseClient.from(any)).thenReturn(mockSupabaseQueryBuilder);
  });

  test('registerUserInfo registers user and inserts data successfully', () async {
    final testUser = user.User(
      name: 'Test User',
      email: 'test@example.com',
      address: '123 Test St',
      phoneNumber: 1234567890,
      password: 'password',
      role: 'owner',
      company: 'Test Company',
      cif: '12345678',
    );
    when(mockSupabaseQueryBuilder.insert(any));

    await userService.registerUserInfo(testUser);

       verify(mockSupabaseQueryBuilder.insert({
      'name': testUser.name,
      'email': testUser.email,
      'address': testUser.address,
      'phoneNumber': testUser.phoneNumber,
      'password': testUser.password,
      'role': testUser.role,
      'company': testUser.company,
      'cif': testUser.cif,
    })).called(1);
  });
}
*/