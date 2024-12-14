import 'package:injector/injector.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/services/pet/pets_service.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
import 'package:injector/injector.dart';
import 'package:petuco/data/repository/impl/user_repository.dart';
import 'package:petuco/data/services/user/user_service.dart';
import 'package:petuco/domain/usecases/impl/get_user_info_use_case.dart';
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
        userRepository: appInjector.get<UserRepository>(),
      ));
}