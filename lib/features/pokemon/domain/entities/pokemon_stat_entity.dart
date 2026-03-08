import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_stat_entity.freezed.dart';

@freezed
abstract class PokemonStatEntity with _$PokemonStatEntity {
  const factory PokemonStatEntity({
    required String statName,
    required int baseStat,
  }) = _PokemonStatEntity;
}
