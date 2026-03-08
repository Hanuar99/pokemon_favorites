import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/pokemon_detail_entity.dart';
import '../entities/pokemon_entity.dart';

abstract interface class PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, PokemonDetailEntity>> getPokemonDetail(String name);

  Future<Either<Failure, bool>> toggleFavorite(PokemonEntity pokemon);

  Either<Failure, List<PokemonEntity>> getFavorites();

  bool isFavorite(int pokemonId);
}
