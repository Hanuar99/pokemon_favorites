import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon_entity.dart';

part 'pokemon_model.freezed.dart';
part 'pokemon_model.g.dart';

/// Data-layer model representing a Pokémon.
///
/// Used both to deserialise API responses (list endpoint) and to persist
/// favourites in [SharedPreferences].
/// Conversion to/from the domain [PokemonEntity] is handled here so the rest
/// of the data layer never needs to touch the domain directly.
@freezed
abstract class PokemonModel with _$PokemonModel {
  const factory PokemonModel({
    required int id,
    required String name,
    required String imageUrl,
    @Default([]) List<String> types,
  }) = _PokemonModel;

  /// Private constructor required by [freezed] to attach methods.
  const PokemonModel._();

  /// Deserialises from a JSON map.
  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  /// Creates a [PokemonModel] from a domain [PokemonEntity].
  factory PokemonModel.fromEntity(PokemonEntity entity) => PokemonModel(
    id: entity.id,
    name: entity.name,
    imageUrl: entity.imageUrl,
    types: entity.types,
  );

  /// Converts this model to the domain [PokemonEntity].
  PokemonEntity toEntity() =>
      PokemonEntity(id: id, name: name, imageUrl: imageUrl, types: types);
}
