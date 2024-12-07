import 'package:petuco/features/home/data/repositories/pets_repository_interface.dart';
import 'package:petuco/features/home/domain/entities/pet.dart';

class PetsRepository implements PetsRepositoryInterface{
  
  @override
  Future<List<Pet>> getPets() {
    // TODO: implement getPets
    throw UnimplementedError();
    /*await Supabase.instance.client
      .from('Pet')
      .select('name')
      .execute();*/
  }
}