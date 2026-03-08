import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_type_filter_provider.g.dart';

@riverpod
class PokemonTypeFilter extends _$PokemonTypeFilter {
  @override
  Set<String> build() => {};

  void setFilters(Set<String> types) {
    state = Set<String>.from(types);
  }

  void toggleType(String type) {
    final updated = Set<String>.from(state);
    if (updated.contains(type)) {
      updated.remove(type);
    } else {
      updated.add(type);
    }
    state = updated;
  }

  void clearFilters() {
    state = {};
  }
}
