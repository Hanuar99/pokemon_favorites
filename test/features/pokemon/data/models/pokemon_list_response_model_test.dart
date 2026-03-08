import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_list_response_model.dart';

void main() {
  group('PokemonListResponseModel', () {
    late Map<String, dynamic> jsonMap;

    setUp(() {
      final file = File('test/fixtures/pokemon_list_fixture.json');
      jsonMap = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
    });

    test('should deserialize all result items', () {
      // Act
      final model = PokemonListResponseModel.fromJson(jsonMap);

      // Assert
      expect(model.results.length, 3);
    });

    test('should parse pokemon names correctly', () {
      // Act
      final model = PokemonListResponseModel.fromJson(jsonMap);

      // Assert
      expect(model.results[0].name, 'bulbasaur');
      expect(model.results[1].name, 'ivysaur');
      expect(model.results[2].name, 'venusaur');
    });

    test('should extract pokemon IDs from URLs', () {
      // Act
      final model = PokemonListResponseModel.fromJson(jsonMap);

      // Assert
      expect(model.results[0].id, 1);
      expect(model.results[1].id, 2);
      expect(model.results[2].id, 3);
    });

    test('PokemonListItemModel.id should handle trailing slash in URL', () {
      // Arrange
      const item = PokemonListItemModel(
        name: 'charizard',
        url: 'https://pokeapi.co/api/v2/pokemon/6/',
      );

      // Act & Assert
      expect(item.id, 6);
    });
  });
}
