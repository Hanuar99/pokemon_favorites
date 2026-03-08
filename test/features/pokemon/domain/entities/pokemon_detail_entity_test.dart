import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_stat_entity.dart';

import '../../../../helpers/test_data_factory.dart';

void main() {
  group('PokemonDetailEntity', () {
    test('should support value equality via freezed', () {
      // Arrange
      const duplicate = PokemonDetailEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        types: ['grass', 'poison'],
        stats: [
          PokemonStatEntity(statName: 'hp', baseStat: 45),
          PokemonStatEntity(statName: 'attack', baseStat: 49),
          PokemonStatEntity(statName: 'defense', baseStat: 49),
          PokemonStatEntity(statName: 'special-attack', baseStat: 65),
          PokemonStatEntity(statName: 'special-defense', baseStat: 65),
          PokemonStatEntity(statName: 'speed', baseStat: 45),
        ],
        heightInMeters: 0.7,
        weightInKg: 6.9,
        baseExperience: 64,
        abilities: ['overgrow'],
      );

      // Assert
      expect(duplicate, tPokemonDetailEntity);
    });

    test('should default stats, types, and abilities to empty lists', () {
      // Arrange & Act
      const entity = PokemonDetailEntity(
        id: 1,
        name: 'test',
        imageUrl: 'https://example.com/test.png',
        heightInMeters: 1.0,
        weightInKg: 10.0,
      );

      // Assert
      expect(entity.stats, isEmpty);
      expect(entity.types, isEmpty);
      expect(entity.abilities, isEmpty);
      expect(entity.baseExperience, 0);
    });

    test('should not be equal when stats differ', () {
      // Arrange
      const different = PokemonDetailEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        stats: [PokemonStatEntity(statName: 'hp', baseStat: 99)],
        heightInMeters: 0.7,
        weightInKg: 6.9,
      );

      // Assert
      expect(different, isNot(tPokemonDetailEntity));
    });
  });

  group('PokemonStatEntity', () {
    test('should support value equality', () {
      const s1 = PokemonStatEntity(statName: 'hp', baseStat: 45);
      const s2 = PokemonStatEntity(statName: 'hp', baseStat: 45);

      expect(s1, s2);
    });

    test('should not be equal when baseStat differs', () {
      const s1 = PokemonStatEntity(statName: 'hp', baseStat: 45);
      const s2 = PokemonStatEntity(statName: 'hp', baseStat: 99);

      expect(s1, isNot(s2));
    });
  });
}
