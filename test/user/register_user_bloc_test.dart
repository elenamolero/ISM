import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:petuco/domain/entities/user.entity.dart';
import 'package:petuco/domain/usecases/register_user_use_case_interface.dart';
import 'package:petuco/presentation/blocs/users/register_user_bloc.dart';

import 'register_user_bloc_test.mocks.dart';

@GenerateMocks([RegisterUserUseCaseInterface])
void main() {
  late MockRegisterUserUseCaseInterface mockRegisterUserUseCase;
  late RegisterUserInfoBloc registerUserInfoBloc;

  setUp(() {
    mockRegisterUserUseCase = MockRegisterUserUseCaseInterface();
    registerUserInfoBloc = RegisterUserInfoBloc(registerUserInfoUseCase: mockRegisterUserUseCase);
  });

  final testUser = User(
    name: 'Test User',
    email: 'test@example.com',
    address: '123 Test St',
    phoneNumber: 1234567890,
    password: 'password',
    role: 'owner',
  );

  blocTest<RegisterUserInfoBloc, RegisterUserInfoState>(
    'emits [RegisterUserLoading, RegisterUserSuccess] when RegisterUserEvent is added and use case succeeds',
    build: () {
      when(mockRegisterUserUseCase.registerUserInfo(any)).thenAnswer((_) async => {});
      return registerUserInfoBloc;
    },
    act: (bloc) => bloc.add(RegisterUserEvent(testUser)),
    expect: () => [
      RegisterUserLoading(),
      RegisterUserSuccess(),
    ],
    verify: (_) {
      verify(mockRegisterUserUseCase.registerUserInfo(testUser)).called(1);
    },
  );

  blocTest<RegisterUserInfoBloc, RegisterUserInfoState>(
    'emits [RegisterUserLoading, RegisterUserError] when RegisterUserEvent is added and use case fails',
    build: () {
      when(mockRegisterUserUseCase.registerUserInfo(any)).thenThrow(Exception('Failed to save new user info'));
      return registerUserInfoBloc;
    },
    act: (bloc) => bloc.add(RegisterUserEvent(testUser)),
    expect: () => [
      RegisterUserLoading(),
      RegisterUserError('Failed to save new user info'),
    ],
    verify: (_) {
      verify(mockRegisterUserUseCase.registerUserInfo(testUser)).called(1);
    },
  );
}