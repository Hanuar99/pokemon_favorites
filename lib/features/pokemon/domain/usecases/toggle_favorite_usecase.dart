import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

final class ToggleFavoriteUseCase extends UseCase<bool, PokemonEntity> {
  const ToggleFavoriteUseCase({required this.repository});

  final PokemonRepository repository;

  @override
  Future<Either<Failure, bool>> call(PokemonEntity params) {
    return repository.toggleFavorite(params);
  }
}
