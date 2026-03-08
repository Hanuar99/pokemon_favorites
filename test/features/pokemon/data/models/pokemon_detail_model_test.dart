import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_detail_model.dart';

void main() {
  group('PokemonDetailModel', () {
    late Map<String, dynamic> jsonMap;

    setUp(() {
      final file = File('test/fixtures/pokemon_detail_fixture.json');
      jsonMap = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
    });

    test('should deserialize id, name, height, weight from JSON', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert
      expect(model.id, 1);
      expect(model.name, 'bulbasaur');
      expect(model.height, 7);
      expect(model.weight, 69);
      expect(model.baseExperience, 64);
    });

    test('should deserialize types, stats, and abilities', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert
      expect(model.types.length, 2);
      expect(model.stats.length, 6);
      expect(model.abilities.length, 2);
    });

    test('should compute heightInMeters as height / 10', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert
      expect(model.heightInMeters, closeTo(0.7, 0.001));
    });

    test('should compute weightInKg as weight / 10', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert
      expect(model.weightInKg, closeTo(6.9, 0.001));
    });

    test('should return frontDefault in bestImageUrl', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert
      expect(
        model.cardImageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
    });

    test('bestImageUrl should equal frontDefault value from fixture', () {
      // Arrange
      final model = PokemonDetailModel.fromJson(jsonMap);

      // Assert — bestImageUrl is the frontDefault sprite, not official artwork
      expect(model.cardImageUrl, model.sprites.frontDefault);
    });

    test('toDetailEntity should filter hidden abilities', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);
      final entity = model.toDetailEntity();

      // Assert
      expect(entity.abilities, ['overgrow']);
      expect(entity.abilities, isNot(contains('chlorophyll')));
    });

    test('toDetailEntity should map all stats correctly', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);
      final entity = model.toDetailEntity();

      // Assert
      expect(entity.stats.length, 6);
      expect(entity.stats[0].statName, 'hp');
      expect(entity.stats[0].baseStat, 45);
      expect(entity.stats[1].statName, 'attack');
      expect(entity.stats[1].baseStat, 49);
    });

    test('toDetailEntity should produce correct types', () {
      // Act
      final model = PokemonDetailModel.fromJson(jsonMap);
      final entity = model.toDetailEntity();

      // Assert
      expect(entity.types, ['grass', 'poison']);
    });

    test(
      'toDetailEntity should preserve id, name, converted height/weight',
      () {
        // Act
        final entity = PokemonDetailModel.fromJson(jsonMap).toDetailEntity();

        // Assert
        expect(entity.id, 1);
        expect(entity.name, 'bulbasaur');
        expect(entity.heightInMeters, closeTo(0.7, 0.001));
        expect(entity.weightInKg, closeTo(6.9, 0.001));
        expect(entity.baseExperience, 64);
      },
    );
  });
}
