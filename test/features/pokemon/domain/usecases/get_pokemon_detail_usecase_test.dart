import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/get_pokemon_detail_usecase.dart';

import '../../../../helpers/mock_classes.dart';
import '../../../../helpers/test_data_factory.dart';

void main() {
  late GetPokemonDetailUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = GetPokemonDetailUseCase(repository: mockRepository);
  });

  group('GetPokemonDetailUseCase', () {
    test(
      'should return PokemonDetailEntity when repository succeeds',
      () async {
        // Arrange
        when(
          () => mockRepository.getPokemonDetail('bulbasaur'),
        ).thenAnswer((_) async => const Right(tPokemonDetailEntity));

        // Act
        final result = await useCase('bulbasaur');

        // Assert
        expect(
          result,
          const Right<dynamic, PokemonDetailEntity>(tPokemonDetailEntity),
        );
        verify(() => mockRepository.getPokemonDetail('bulbasaur')).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return ServerFailure when repository returns error', () async {
      // Arrange
      when(
        () => mockRepository.getPokemonDetail('bulbasaur'),
      ).thenAnswer((_) async => const Left(TestFailures.server));

      // Act
      final result = await useCase('bulbasaur');

      // Assert
      expect(result, const Left(TestFailures.server));
      verify(() => mockRepository.getPokemonDetail('bulbasaur')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should normalize uppercase name to lowercase before calling repository',
      () async {
        // Arrange
        when(
          () => mockRepository.getPokemonDetail('bulbasaur'),
        ).thenAnswer((_) async => const Right(tPokemonDetailEntity));

        // Act
        await useCase('BULBASAUR');

        // Assert — el repositorio recibe 'bulbasaur', no 'BULBASAUR'
        verify(() => mockRepository.getPokemonDetail('bulbasaur')).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should normalize mixed-case name to lowercase', () async {
      // Arrange
      when(
        () => mockRepository.getPokemonDetail('pikachu'),
      ).thenAnswer((_) async => const Right(tPokemonDetailEntity));

      // Act
      await useCase('PiKaChU');

      // Assert
      verify(() => mockRepository.getPokemonDetail('pikachu')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return NetworkFailure when there is no connection', () async {
      // Arrange
      when(
        () => mockRepository.getPokemonDetail('bulbasaur'),
      ).thenAnswer((_) async => const Left(TestFailures.network));

      // Act
      final result = await useCase('bulbasaur');

      // Assert
      expect(result, const Left(TestFailures.network));
      verify(() => mockRepository.getPokemonDetail('bulbasaur')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
