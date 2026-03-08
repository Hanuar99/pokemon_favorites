import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_entity.freezed.dart';

@freezed
abstract class PokemonEntity with _$PokemonEntity {
  const factory PokemonEntity({
    required int id,
    required String name,
    required String imageUrl,
    @Default([]) List<String> types,
  }) = _PokemonEntity;
}
