import 'package:injector/injector.dart';
import 'package:petuco/data/repository/impl/pet_repository_impl.dart';
import 'package:petuco/data/repository/pets_repository_interface.dart';
import 'package:petuco/data/service/pets_service.dart';
import 'package:petuco/domain/usecases/impl/get_pets_home_use_case.dart';
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
}