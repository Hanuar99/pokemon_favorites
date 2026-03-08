import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';
import 'get_pokemon_list_params.dart';

class GetPokemonListUseCase
    extends UseCase<List<PokemonEntity>, GetPokemonListParams> {
  const GetPokemonListUseCase({required this.repository});

  final PokemonRepository repository;
  @override
  Future<Either<Failure, List<PokemonEntity>>> call(
    GetPokemonListParams params,
  ) {
    return repository.getPokemonList(
      limit: params.limit,
      offset: params.offset,
    );
  }
}
