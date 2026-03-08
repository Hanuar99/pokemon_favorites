import 'package:freezed_annotation/freezed_annotation.dart';

import 'pokemon_stat_entity.dart';

part 'pokemon_detail_entity.freezed.dart';

@freezed
abstract class PokemonDetailEntity with _$PokemonDetailEntity {
  const factory PokemonDetailEntity({
    required int id,
    required String name,
    required String imageUrl,
    @Default([]) List<String> types,
    @Default([]) List<PokemonStatEntity> stats,
    required double heightInMeters,
    required double weightInKg,
    @Default(0) int baseExperience,
    @Default([]) List<String> abilities,
  }) = _PokemonDetailEntity;
}
