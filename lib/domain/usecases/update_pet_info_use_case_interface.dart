import 'dart:io';

import 'package:petuco/domain/entities/pet.entity.dart';

abstract class UpdatePetInfoUseCaseInterface {
  Future<void> updatePetInfo(Pet pet, File? imageFile);
}