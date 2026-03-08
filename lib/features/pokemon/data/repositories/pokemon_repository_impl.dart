import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final PokemonRemoteDatasource remoteDatasource;
  final PokemonLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final models = await remoteDatasource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return Right(models.map((PokemonModel m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailEntity>> getPokemonDetail(
    String name,
  ) async {
    try {
      final model = await remoteDatasource.getPokemonDetail(name);
      return Right(model.toDetailEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(PokemonEntity pokemon) async {
    try {
      if (localDatasource.isFavorite(pokemon.id)) {
        await localDatasource.removeFavorite(pokemon.id);
        return const Right(false);
      } else {
        await localDatasource.saveFavorite(pokemon);
        return const Right(true);
      }
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Either<Failure, List<PokemonEntity>> getFavorites() {
    try {
      final favorites = localDatasource.getFavorites();
      return Right(favorites);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  bool isFavorite(int pokemonId) {
    return localDatasource.isFavorite(pokemonId);
  }
}
