import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/usecases/usecase.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/get_favorites_usecase.dart';

import '../../../../helpers/mock_classes.dart';
import '../../../../helpers/test_data_factory.dart';

void main() {
  late GetFavoritesUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = GetFavoritesUseCase(repository: mockRepository);
  });

  group('GetFavoritesUseCase', () {
    test('should return list of favorites when repository succeeds', () {
      // Arrange
      when(
        () => mockRepository.getFavorites(),
      ).thenReturn(const Right(tPokemonList));

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, List<PokemonEntity>>(tPokemonList));
      verify(() => mockRepository.getFavorites()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no favorites exist', () {
      // Arrange
      when(
        () => mockRepository.getFavorites(),
      ).thenReturn(const Right(<PokemonEntity>[]));

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, List<PokemonEntity>>([]));
      verify(() => mockRepository.getFavorites()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return CacheFailure when local read fails', () {
      // Arrange
      when(
        () => mockRepository.getFavorites(),
      ).thenReturn(const Left(TestFailures.cache));

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result, const Left(TestFailures.cache));
      verify(() => mockRepository.getFavorites()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
