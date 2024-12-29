import 'dart:io';

import 'package:petuco/domain/entities/pet.entity.dart';

abstract class SavePetInfoUseCaseInterface {
  Future<void> savePetInfo(Pet pet, File? imageFile);
}