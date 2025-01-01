import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/entities/user.entity.dart';
import 'package:petuco/data/services/model/user_response.dart'
    as app_user_response;

// Generate mocks
@GenerateMocks([SupabaseClient, GoTrueClient])
import 'user_service_test.mocks.dart';

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {
  @override
  SupabaseQueryBuilder eq(String column, dynamic value) => this;

  @override
  SupabaseQueryBuilder select([String columns = '*']) => this;

  @override
  Future<Map<String, dynamic>> single() async {
    return {};
  }

  @override
  Future<List<Map<String, dynamic>>> execute() async {
    return [];
  }

  @override
  SupabaseQueryBuilder update(Map<String, dynamic> value) => this;

  @override
  SupabaseQueryBuilder insert(Map<String, dynamic> value) => this;
}

void main() {
  late UserService userService;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockSupabaseQueryBuilder mockQueryBuilder;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockQueryBuilder = MockSupabaseQueryBuilder();

    // Set up Supabase instance
    Supabase.initialize(
      url: 'https://example.supabase.co',
      anonKey: 'your-anon-key',
    );

    when(Supabase.instance.client).thenReturn(mockSupabaseClient);
    when(mockSupabaseClient.auth).thenReturn(mockGoTrueClient);

    userService = UserService();
  });

  group('UserService', () {
    test('getUserInfo returns UserResponse when user exists', () async {
      final email = 'test@example.com';
      final userData = {
        'name': 'Test User',
        'email': email,
        'address': 'Test Address',
        'phoneNumber': '1234567890',
        'role': 'user',
      };

      when(mockSupabaseClient.from('User')).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.single()).thenAnswer((_) async => userData);

      final result = await userService.getUserInfo(email);

      expect(result, isA<app_user_response.UserResponse>());
      expect(result?.name, userData['name']);
      expect(result?.email, userData['email']);
    });

    test('getUserInfo returns null when user does not exist', () async {
      final email = 'nonexistent@example.com';

      when(mockSupabaseClient.from('User')).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.single()).thenAnswer((_) async => null);

      final result = await userService.getUserInfo(email);

      expect(result, isNull);
    });

    test('saveUserInfo updates user information', () async {
      final user = User(
        name: 'Updated User',
        email: 'test@example.com',
        address: 'Updated Address',
        phoneNumber: '9876543210',
        password: 'newpassword',
        role: 'user',
        company: 'Test Company',
        cif: '12345678A',
      );

      when(mockSupabaseClient.from('User')).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.execute()).thenAnswer((_) async => []);
      when(mockGoTrueClient.updateUser(any))
          .thenAnswer((_) async => UserResponse());

      await userService.saveUserInfo(user);

      verify(mockSupabaseClient.from('User')).called(1);
      verify(mockQueryBuilder.update(any)).called(1);
      verify(mockGoTrueClient.updateUser(any)).called(1);
    });

    test('registerUserInfo creates new user', () async {
      final user = User(
        name: 'New User',
        email: 'newuser@example.com',
        address: 'New Address',
        phoneNumber: '1231231234',
        password: 'password123',
        role: 'user',
        company: 'New Company',
        cif: '87654321B',
      );

      when(mockGoTrueClient.signUp(
        email: user.email,
        password: user.password,
        data: {'role': user.role},
      )).thenAnswer((_) async => AuthResponse());

      when(mockSupabaseClient.from('User')).thenReturn(mockQueryBuilder);
      when(mockQueryBuilder.execute()).thenAnswer((_) async => []);

      await userService.registerUserInfo(user);

      verify(mockGoTrueClient.signUp(
        email: user.email,
        password: user.password,
        data: {'role': user.role},
      )).called(1);
      verify(mockSupabaseClient.from('User')).called(1);
      verify(mockQueryBuilder.insert(any)).called(1);
    });

    test('loginUser signs in user', () async {
      final user = User(
        email: 'test@example.com',
        password: 'password123',
        name: '',
        address: '',
        phoneNumber: '',
        role: '',
        company: '',
        cif: '',
      );

      when(mockGoTrueClient.signInWithPassword(
        email: user.email,
        password: user.password,
      )).thenAnswer((_) async => AuthResponse());

      await userService.loginUser(user);

      verify(mockGoTrueClient.signInWithPassword(
        email: user.email,
        password: user.password,
      )).called(1);
    });
  });
}
