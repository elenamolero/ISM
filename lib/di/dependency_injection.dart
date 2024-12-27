import 'package:injector/injector.dart';
import 'package:petuco/data/repository/impl/health_test_repository_impl.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/services/healthTest/health_test_service.dart';
import 'package:petuco/data/services/model/pet_response.dart';
import 'package:petuco/domain/usecases/impl/get_health_tests_use_case.dart';
import 'package:petuco/domain/usecases/impl/get_pet_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
import 'package:petuco/data/repository/impl/user_repository.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/login_user_use_case.dart';
import 'package:petuco/domain/usecases/impl/register_user_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_health_test_info_use_case.dart';
import 'package:petuco/domain/usecases/impl/save_user_info_use_case.dart';

final appInjector = Injector.appInstance;
void initInjection() {

  // Data sources injection
  appInjector.registerSingleton<PetsService>(() => PetsService());

  // Repository injection
  appInjector.registerSingleton<PetRepositoryImpl>(() => PetRepositoryImpl(
        petsService: appInjector.get<PetsService>(),
      ));

  // Use case injection
  appInjector.registerSingleton<GetPetsHomeUseCase>(() => GetPetsHomeUseCase(
        petsRepository: appInjector.get<PetRepositoryImpl>(),
              ));

  // Use case injection
  appInjector.registerSingleton<GetPetInfoUseCase>(() => GetPetInfoUseCase(
        petRepository: appInjector.get<PetRepositoryImpl>(),
              ));


 // Data sources injection
  appInjector.registerSingleton<HealthTestsService>(() => HealthTestsService());

  // Repository injection
  appInjector.registerSingleton<HealthTestRepositoryImpl>(() => HealthTestRepositoryImpl(
        healthTestsService: appInjector.get<HealthTestsService>(),
      ));

  // Use case injection
  appInjector.registerSingleton<GetHealthTestsUseCase>(() => GetHealthTestsUseCase(
        healthTestsRepository: appInjector.get<HealthTestRepositoryImpl>(),
              ));

  appInjector.registerSingleton<LoginUserUseCase>(() => LoginUserUseCase(
        userRepository: appInjector.get<UserRepository>(),
      ));

  // Data sources injection
  appInjector.registerSingleton<UserService>(() => UserService());

  // Repository injection
  appInjector.registerSingleton<UserRepository>(() => UserRepository(
        userService: appInjector.get<UserService>(),
      ));

  // Use case injection
  appInjector.registerSingleton<GetUserInfoUseCase>(() => GetUserInfoUseCase(
        userRepositoryInterface: appInjector.get<UserRepository>(),
      ));

  appInjector.registerSingleton<SaveUserInfoUseCase>(() => SaveUserInfoUseCase(
        userRepositoryInterface: appInjector.get<UserRepository>(),
      ));

  appInjector.registerSingleton<RegisterUserInfoUseCase>(() => RegisterUserInfoUseCase(
        userRepository: appInjector.get<UserRepository>(),
      ));
  appInjector.registerSingleton<SaveHealthTestInfoUseCase>(() => SaveHealthTestInfoUseCase(
        healthTestRepository: appInjector.get<HealthTestRepositoryImpl>(),
      ));
}