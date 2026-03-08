import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_detail_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetailUseCase extends UseCase<PokemonDetailEntity, String> {
  const GetPokemonDetailUseCase({required this.repository});

  final PokemonRepository repository;

  @override
  Future<Either<Failure, PokemonDetailEntity>> call(String params) {
    return repository.getPokemonDetail(params.toLowerCase());
  }
}
