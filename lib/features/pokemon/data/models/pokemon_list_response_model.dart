import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_list_response_model.freezed.dart';
part 'pokemon_list_response_model.g.dart';

@freezed
abstract class PokemonListResponseModel with _$PokemonListResponseModel {
  const factory PokemonListResponseModel({
    required List<PokemonListItemModel> results,
  }) = _PokemonListResponseModel;

  factory PokemonListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseModelFromJson(json);
}

@freezed
abstract class PokemonListItemModel with _$PokemonListItemModel {
  /// Creates a [PokemonListItemModel].
  const factory PokemonListItemModel({
    required String name,
    required String url,
  }) = _PokemonListItemModel;

  const PokemonListItemModel._();

  /// Deserializes from JSON.
  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListItemModelFromJson(json);

  /// Extracts the Pokémon ID from the resource URL.
  ///
  /// The PokeAPI URL format is `https://pokeapi.co/api/v2/pokemon/{id}/`.
  int get id {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    return int.parse(segments.last);
  }
}
