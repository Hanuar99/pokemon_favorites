import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/get_pokemon_list_params.dart';

import '../../../../helpers/mock_classes.dart';
import '../../../../helpers/test_data_factory.dart';

void main() {
  late GetPokemonListUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = GetPokemonListUseCase(repository: mockRepository);
  });

  const tParams = GetPokemonListParams(limit: 20, offset: 0);

  group('GetPokemonListUseCase', () {
    test(
      'should return List<PokemonEntity> when repository succeeds',
      () async {
        // Arrange
        when(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).thenAnswer((_) async => const Right(tPokemonList));

        // Act
        final result = await useCase(tParams);

        // Assert
        expect(result, const Right<dynamic, List<PokemonEntity>>(tPokemonList));
        verify(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ServerFailure when repository returns server error',
      () async {
        // Arrange
        when(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).thenAnswer((_) async => const Left(TestFailures.server));

        // Act
        final result = await useCase(tParams);

        // Assert
        expect(result, const Left(TestFailures.server));
        verify(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return NetworkFailure when repository returns network error',
      () async {
        // Arrange
        when(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).thenAnswer((_) async => const Left(TestFailures.network));

        // Act
        final result = await useCase(tParams);

        // Assert
        expect(result, const Left(TestFailures.network));
        verify(
          () => mockRepository.getPokemonList(
            limit: tParams.limit,
            offset: tParams.offset,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should forward limit and offset correctly to repository', () async {
      // Arrange
      const customParams = GetPokemonListParams(limit: 10, offset: 40);
      when(
        () => mockRepository.getPokemonList(limit: 10, offset: 40),
      ).thenAnswer((_) async => const Right(<PokemonEntity>[]));

      // Act
      await useCase(customParams);

      // Assert
      verify(
        () => mockRepository.getPokemonList(limit: 10, offset: 40),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('GetPokemonListParams default values should be limit=20 offset=0', () {
      // Arrange & Act
      const params = GetPokemonListParams();

      // Assert
      expect(params.limit, 20);
      expect(params.offset, 0);
    });
  });
}
