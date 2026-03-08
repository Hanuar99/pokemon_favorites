import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetFavoritesUseCase extends SyncUseCase<List<PokemonEntity>, NoParams> {
  const GetFavoritesUseCase({required this.repository});

  final PokemonRepository repository;

  @override
  Either<Failure, List<PokemonEntity>> call(NoParams params) {
    return repository.getFavorites();
  }
}
