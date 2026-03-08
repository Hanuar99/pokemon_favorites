import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../models/pokemon_model.dart';

abstract interface class PokemonLocalDatasource {
  Future<void> init();

  List<PokemonEntity> getFavorites();

  Future<void> saveFavorite(PokemonEntity pokemon);

  Future<void> removeFavorite(int id);

  bool isFavorite(int pokemonId);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  PokemonLocalDatasourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  List<PokemonModel>? _cachedFavorites;

  @override
  Future<void> init() async {
    try {
      final jsonStrings = sharedPreferences.getStringList(
        AppConstants.favoritesStorageKey,
      );
      if (jsonStrings != null) {
        _cachedFavorites = jsonStrings
            .map(
              (s) =>
                  PokemonModel.fromJson(json.decode(s) as Map<String, dynamic>),
            )
            .toList();
      } else {
        _cachedFavorites = [];
      }
    } catch (e) {
      _cachedFavorites = [];
      throw CacheException(message: 'Failed to load favorites: $e');
    }
  }

  @override
  List<PokemonEntity> getFavorites() {
    return (_cachedFavorites ?? [])
        .map((model) => model.toEntity())
        .toList(growable: false);
  }

  @override
  Future<void> saveFavorite(PokemonEntity pokemon) async {
    _cachedFavorites ??= [];
    if (_cachedFavorites!.any((m) => m.id == pokemon.id)) return;

    _cachedFavorites!.add(PokemonModel.fromEntity(pokemon));
    await _persist();
  }

  @override
  Future<void> removeFavorite(int id) async {
    _cachedFavorites?.removeWhere((m) => m.id == id);
    await _persist();
  }

  @override
  bool isFavorite(int pokemonId) {
    return _cachedFavorites?.any((m) => m.id == pokemonId) ?? false;
  }

  Future<void> _persist() async {
    try {
      final jsonStrings = (_cachedFavorites ?? [])
          .map((m) => json.encode(m.toJson()))
          .toList();
      final result = await sharedPreferences.setStringList(
        AppConstants.favoritesStorageKey,
        jsonStrings,
      );
      if (!result) {
        throw const CacheException(message: 'Failed to persist favorites.');
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Failed to persist favorites: $e');
    }
  }
}
