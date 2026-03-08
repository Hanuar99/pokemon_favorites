import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/toggle_favorite_usecase.dart';

import '../../../../helpers/mock_classes.dart';
import '../../../../helpers/test_data_factory.dart';

void main() {
  late ToggleFavoriteUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUpAll(() {
    // Necesario para mocktail cuando se pasan instancias freezed como fallback.
    registerFallbackValue(tPokemonEntity);
  });

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = ToggleFavoriteUseCase(repository: mockRepository);
  });

  group('ToggleFavoriteUseCase', () {
    test('should return true when pokemon is added to favorites', () async {
      // Arrange
      when(
        () => mockRepository.toggleFavorite(tPokemonEntity),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await useCase(tPokemonEntity);

      // Assert
      expect(result, const Right<dynamic, bool>(true));
      verify(() => mockRepository.toggleFavorite(tPokemonEntity)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return false when pokemon is removed from favorites',
      () async {
        // Arrange
        when(
          () => mockRepository.toggleFavorite(tPokemonEntity),
        ).thenAnswer((_) async => const Right(false));

        // Act
        final result = await useCase(tPokemonEntity);

        // Assert
        expect(result, const Right<dynamic, bool>(false));
        verify(() => mockRepository.toggleFavorite(tPokemonEntity)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return CacheFailure when local persistence fails', () async {
      // Arrange
      when(
        () => mockRepository.toggleFavorite(tPokemonEntity),
      ).thenAnswer((_) async => const Left(TestFailures.cache));

      // Act
      final result = await useCase(tPokemonEntity);

      // Assert
      expect(result, const Left(TestFailures.cache));
      verify(() => mockRepository.toggleFavorite(tPokemonEntity)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass the exact PokemonEntity to the repository', () async {
      // Arrange
      const pikachu = PokemonEntity(
        id: 25,
        name: 'pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        types: ['electric'],
      );
      when(
        () => mockRepository.toggleFavorite(pikachu),
      ).thenAnswer((_) async => const Right(true));

      // Act
      await useCase(pikachu);

      // Assert
      verify(() => mockRepository.toggleFavorite(pikachu)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
