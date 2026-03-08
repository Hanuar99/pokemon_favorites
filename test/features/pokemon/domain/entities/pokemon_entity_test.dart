import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../../../helpers/test_data_factory.dart';

void main() {
  group('PokemonEntity', () {
    test('should support value equality via freezed', () {
      // Arrange
      const entity = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        types: ['grass', 'poison'],
      );

      // Assert
      expect(entity, tPokemonEntity);
    });

    test('should not be equal when id differs', () {
      // Arrange
      const different = PokemonEntity(
        id: 999,
        name: 'bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        types: ['grass', 'poison'],
      );

      // Assert
      expect(different, isNot(tPokemonEntity));
    });

    test('should default types to empty list when not provided', () {
      // Arrange & Act
      const entity = PokemonEntity(
        id: 132,
        name: 'ditto',
        imageUrl: 'https://example.com/ditto.png',
      );

      // Assert
      expect(entity.types, isEmpty);
    });

    test('should produce updated entity via copyWith', () {
      // Act
      final modified = tPokemonEntity.copyWith(name: 'charmander', id: 4);

      // Assert
      expect(modified.name, 'charmander');
      expect(modified.id, 4);
      expect(modified.imageUrl, tPokemonEntity.imageUrl);
      expect(modified.types, tPokemonEntity.types);
    });

    test('should not modify original entity after copyWith', () {
      // Act
      final _ = tPokemonEntity.copyWith(name: 'changed');

      // Assert — original no mutado
      expect(tPokemonEntity.name, 'bulbasaur');
    });
  });
}
