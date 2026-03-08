import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pokemon_detail_entity.dart';
import '../../di/pokemon_module.dart';

part 'pokemon_detail_provider.g.dart';

@riverpod
class PokemonDetail extends _$PokemonDetail {
  @override
  Future<PokemonDetailEntity> build(String pokemonName) async {
    final useCase = await ref.read(getPokemonDetailUseCaseProvider.future);

    final result = await useCase(pokemonName);

    return result.fold(
      (failure) => throw _DetailFailureException(failure.toString()),
      (detail) => detail,
    );
  }
}

class _DetailFailureException implements Exception {
  const _DetailFailureException(this.message);

  final String message;

  @override
  String toString() => message;
}
