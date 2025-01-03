import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:petuco/data/repository/user_repository_interface.dart';
import 'package:petuco/domain/entities/user.entity.dart';
import 'package:petuco/domain/usecases/impl/register_user_use_case.dart';

import 'register_user_use_case_test.mocks.dart';

@GenerateMocks([UserRepositoryInterface])
void main() {
  late MockUserRepositoryInterface mockUserRepository;
  late RegisterUserInfoUseCase registerUserInfoUseCase;

  setUp(() {
    mockUserRepository = MockUserRepositoryInterface();
    registerUserInfoUseCase = RegisterUserInfoUseCase(userRepositoryInterface: mockUserRepository);
  });

  final testUser = User(
    name: 'Test User',
    email: 'test@example.com',
    address: '123 Test St',
    phoneNumber: 1234567890,
    password: 'password',
    role: 'vet',
    company: 'Test Company',
    cif: '12345678',
  );

  test('registerUserInfo calls registerUserInfo on UserRepositoryInterface', () async {
    when(mockUserRepository.registerUserInfo(any)).thenAnswer((_) async => {});
    await registerUserInfoUseCase.registerUserInfo(testUser);
    verify(mockUserRepository.registerUserInfo(testUser)).called(1);
  });

  test('registerUserInfo throws an exception when UserRepositoryInterface fails', () async {
    when(mockUserRepository.registerUserInfo(any)).thenThrow(Exception('Failed to register user'));
    expect(() => registerUserInfoUseCase.registerUserInfo(testUser), throwsException);
    verify(mockUserRepository.registerUserInfo(testUser)).called(1);
  });
}