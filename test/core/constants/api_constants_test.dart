import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/core/constants/api_constants.dart';

void main() {
  group('ApiConstants', () {
    test('baseUrl should point to PokeAPI v2', () {
      expect(ApiConstants.baseUrl, 'https://pokeapi.co/api/v2');
    });

    test('pokemonEndpoint should be /pokemon', () {
      expect(ApiConstants.pokemonEndpoint, '/pokemon');
    });

    test('pokemonDetailEndpoint should interpolate name correctly', () {
      expect(ApiConstants.pokemonDetailEndpoint('pikachu'), '/pokemon/pikachu');
      expect(ApiConstants.pokemonDetailEndpoint('25'), '/pokemon/25');
    });
  });
}
