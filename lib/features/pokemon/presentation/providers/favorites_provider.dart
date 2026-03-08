import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../di/pokemon_module.dart';

part 'favorites_provider.g.dart';

@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  @override
  List<PokemonEntity> build() {
    final useCaseAsync = ref.watch(getFavoritesUseCaseProvider);

    return useCaseAsync.when(
      data: (useCase) {
        final result = useCase(const NoParams());
        return result.fold((_) => <PokemonEntity>[], (favorites) => favorites);
      },
      loading: () => <PokemonEntity>[],
      error: (_, _) => <PokemonEntity>[],
    );
  }

  Future<void> toggleFavorite(PokemonEntity pokemon) async {
    final previousState = List<PokemonEntity>.of(state);
    final isCurrentlyFavorite = isFavorite(pokemon.id);

    if (isCurrentlyFavorite) {
      state = [
        for (final p in state)
          if (p.id != pokemon.id) p,
      ];
    } else {
      state = [...state, pokemon];
    }

    final useCase = await ref.read(toggleFavoriteUseCaseProvider.future);

    final result = await useCase(pokemon);

    result.fold((_) {
      state = previousState;
    }, (_) {});
  }

  bool isFavorite(int pokemonId) {
    return state.any((p) => p.id == pokemonId);
  }
}
