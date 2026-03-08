import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_search_provider.g.dart';

@riverpod
class PokemonSearch extends _$PokemonSearch {
  @override
  String build() => '';

  /// Actualiza el query de búsqueda.
  void updateSearch(String query) {
    state = query;
  }

  /// Limpia la búsqueda.
  void clear() {
    state = '';
  }
}
