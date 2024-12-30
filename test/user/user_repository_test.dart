import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:petuco/data/repository/impl/user_repository.dart';
import 'package:petuco/data/services/model/user_response.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/entities/user.entity.dart' as user;

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  late MockUserService mockUserService;
  late UserRepository userRepository;

  setUp(() {
    mockUserService = MockUserService();
    userRepository = UserRepository(userService: mockUserService);
  });

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

  test('registerUserInfo calls registerUserInfo on UserService', () async {
    // Arrange
    when(mockUserService.registerUserInfo(any)).thenAnswer((_) async => {});

    // Act
    await userRepository.registerUserInfo(testUser);

    // Assert
    verify(mockUserService.registerUserInfo(testUser)).called(1);
  });

  test('registerUserInfo throws an exception when there is a connection issue', () async {
    // Arrange
    when(mockUserService.registerUserInfo(any)).thenThrow(Exception('Connection issue'));

    // Act & Assert
    expect(() => userRepository.registerUserInfo(testUser), throwsException);
    verify(mockUserService.registerUserInfo(testUser)).called(1);
  });

  test('registerUserInfo throws an exception when there is a validation error', () async {
    // Arrange
    when(mockUserService.registerUserInfo(any)).thenThrow(Exception('Validation error'));

    // Act & Assert
    expect(() => userRepository.registerUserInfo(testUser), throwsException);
    verify(mockUserService.registerUserInfo(testUser)).called(1);
  });

  test('registerUserInfo throws an exception when there is a server error', () async {
    // Arrange
    when(mockUserService.registerUserInfo(any)).thenThrow(Exception('Server error'));

    // Act & Assert
    expect(() => userRepository.registerUserInfo(testUser), throwsException);
    verify(mockUserService.registerUserInfo(testUser)).called(1);
  });

  test('registerUserInfo throws an exception when user data is invalid', () async {
    // Arrange
    final invalidUser = user.User(
      name: '',
      email: '',
      address: '',
      phoneNumber: 0,
      password: '',
      role: '',
      company: '',
      cif: '',
    );

    when(mockUserService.registerUserInfo(any)).thenThrow(Exception('Invalid user data'));

    // Act & Assert
    expect(() => userRepository.registerUserInfo(invalidUser), throwsException);
    verify(mockUserService.registerUserInfo(invalidUser)).called(1);
  });
}