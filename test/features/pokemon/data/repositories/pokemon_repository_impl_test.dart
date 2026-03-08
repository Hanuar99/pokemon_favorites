import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/errors/exceptions.dart';
import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../../../helpers/mock_classes.dart';
import '../../../../helpers/test_data_factory.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDatasource mockRemote;
  late MockPokemonLocalDatasource mockLocal;

  setUpAll(() {
    registerFallbackValue(tPokemonEntity);
  });

  setUp(() {
    mockRemote = MockPokemonRemoteDatasource();
    mockLocal = MockPokemonLocalDatasource();
    repository = PokemonRepositoryImpl(
      remoteDatasource: mockRemote,
      localDatasource: mockLocal,
    );
  });

  // ─── Helper: configura el happy path del listado ─────────────────────────────

  void stubSuccessfulList() {
    when(
      () => mockRemote.getPokemonList(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => tPokemonModelList);
  }

  // ─── getPokemonList ───────────────────────────────────────────────────────────

  group('getPokemonList', () {
    test(
      'should return List<PokemonEntity> when remote calls succeed',
      () async {
        // Arrange
        stubSuccessfulList();

        // Act
        final result = await repository.getPokemonList(limit: 3, offset: 0);

        // Assert
        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Expected Right'), (list) {
          expect(list.length, 3);
          expect(list[0].name, 'bulbasaur');
          expect(list[1].name, 'ivysaur');
          expect(list[2].name, 'venusaur');
        });
        verify(() => mockRemote.getPokemonList(limit: 3, offset: 0)).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );

    test('should map imageUrl from frontDefault sprite URL', () async {
      // Arrange
      stubSuccessfulList();

      // Act
      final result = await repository.getPokemonList(limit: 3, offset: 0);

      // Assert
      result.fold((_) => fail('Expected Right'), (list) {
        expect(
          list[0].imageUrl,
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        );
        expect(
          list[1].imageUrl,
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
        );
      });
    });

    test('should map types correctly from detail model', () async {
      // Arrange
      stubSuccessfulList();

      // Act
      final result = await repository.getPokemonList(limit: 3, offset: 0);

      // Assert
      result.fold((_) => fail('Expected Right'), (list) {
        expect(list[0].types, ['grass', 'poison']);
        expect(list[1].types, ['grass', 'poison']);
      });
    });

    test(
      'should return ServerFailure when ServerException is thrown',
      () async {
        // Arrange
        when(
          () => mockRemote.getPokemonList(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(
          const ServerException(message: 'Server error', statusCode: 500),
        );

        // Act
        final result = await repository.getPokemonList(limit: 20, offset: 0);

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).statusCode, 500);
        }, (_) => fail('Expected Left'));
        verify(() => mockRemote.getPokemonList(limit: 20, offset: 0)).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );

    test(
      'should return NetworkFailure when NetworkException is thrown',
      () async {
        // Arrange
        when(
          () => mockRemote.getPokemonList(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(const NetworkException(message: 'No internet'));

        // Act
        final result = await repository.getPokemonList(limit: 20, offset: 0);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (_) => fail('Expected Left'),
        );
        verify(() => mockRemote.getPokemonList(limit: 20, offset: 0)).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );

    test(
      'should return UnknownFailure when unexpected exception is thrown',
      () async {
        // Arrange
        when(
          () => mockRemote.getPokemonList(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenThrow(Exception('unexpected'));

        // Act
        final result = await repository.getPokemonList(limit: 20, offset: 0);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<UnknownFailure>()),
          (_) => fail('Expected Left'),
        );
        verify(() => mockRemote.getPokemonList(limit: 20, offset: 0)).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );
  });

  // ─── getPokemonDetail ─────────────────────────────────────────────────────────

  group('getPokemonDetail', () {
    test(
      'should return PokemonDetailEntity when remote call succeeds',
      () async {
        // Arrange
        when(
          () => mockRemote.getPokemonDetail('bulbasaur'),
        ).thenAnswer((_) async => tPokemonDetailModel());

        // Act
        final result = await repository.getPokemonDetail('bulbasaur');

        // Assert
        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Expected Right'), (detail) {
          expect(detail.id, 1);
          expect(detail.name, 'bulbasaur');
          expect(detail.types, ['grass', 'poison']);
          expect(detail.stats.length, 6);
          expect(detail.heightInMeters, 0.7);
          expect(detail.weightInKg, 6.9);
          expect(detail.baseExperience, 64);
        });
        verify(() => mockRemote.getPokemonDetail('bulbasaur')).called(1);
        verifyNoMoreInteractions(mockRemote);
      },
    );

    test('should include only non-hidden abilities in entity', () async {
      // Arrange
      when(
        () => mockRemote.getPokemonDetail('bulbasaur'),
      ).thenAnswer((_) async => tPokemonDetailModel());

      // Act
      final result = await repository.getPokemonDetail('bulbasaur');

      // Assert
      result.fold((_) => fail('Expected Right'), (detail) {
        expect(detail.abilities, ['overgrow']);
        expect(detail.abilities, isNot(contains('chlorophyll')));
      });
    });

    test('should return ServerFailure on ServerException with 404', () async {
      // Arrange
      when(
        () => mockRemote.getPokemonDetail('nonexistent'),
      ).thenThrow(const ServerException(message: 'Not Found', statusCode: 404));

      // Act
      final result = await repository.getPokemonDetail('nonexistent');

      // Assert
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect((failure as ServerFailure).statusCode, 404);
      }, (_) => fail('Expected Left'));
      verify(() => mockRemote.getPokemonDetail('nonexistent')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('should return NetworkFailure on NetworkException', () async {
      // Arrange
      when(
        () => mockRemote.getPokemonDetail('bulbasaur'),
      ).thenThrow(const NetworkException(message: 'No internet'));

      // Act
      final result = await repository.getPokemonDetail('bulbasaur');

      // Assert
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
      verify(() => mockRemote.getPokemonDetail('bulbasaur')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  // ─── toggleFavorite ───────────────────────────────────────────────────────────

  group('toggleFavorite', () {
    test(
      'should add pokemon and return true when not already favorite',
      () async {
        // Arrange
        when(() => mockLocal.isFavorite(1)).thenReturn(false);
        when(
          () => mockLocal.saveFavorite(tPokemonEntity),
        ).thenAnswer((_) async {});

        // Act
        final result = await repository.toggleFavorite(tPokemonEntity);

        // Assert
        expect(result, const Right<dynamic, bool>(true));
        verify(() => mockLocal.isFavorite(1)).called(1);
        verify(() => mockLocal.saveFavorite(tPokemonEntity)).called(1);
        verifyNoMoreInteractions(mockLocal);
      },
    );

    test(
      'should remove pokemon and return false when already favorite',
      () async {
        // Arrange
        when(() => mockLocal.isFavorite(1)).thenReturn(true);
        when(() => mockLocal.removeFavorite(1)).thenAnswer((_) async {});

        // Act
        final result = await repository.toggleFavorite(tPokemonEntity);

        // Assert
        expect(result, const Right<dynamic, bool>(false));
        verify(() => mockLocal.isFavorite(1)).called(1);
        verify(() => mockLocal.removeFavorite(1)).called(1);
        verifyNoMoreInteractions(mockLocal);
      },
    );

    test('should return CacheFailure when CacheException is thrown', () async {
      // Arrange
      when(() => mockLocal.isFavorite(1)).thenReturn(false);
      when(
        () => mockLocal.saveFavorite(tPokemonEntity),
      ).thenThrow(const CacheException(message: 'Failed to persist.'));

      // Act
      final result = await repository.toggleFavorite(tPokemonEntity);

      // Assert
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ─── getFavorites ─────────────────────────────────────────────────────────────

  group('getFavorites', () {
    test('should return list from local datasource', () {
      // Arrange
      when(() => mockLocal.getFavorites()).thenReturn(tPokemonList);

      // Act
      final result = repository.getFavorites();

      // Assert
      expect(result, const Right<dynamic, List<PokemonEntity>>(tPokemonList));
      verify(() => mockLocal.getFavorites()).called(1);
      verifyNoMoreInteractions(mockLocal);
    });

    test('should return CacheFailure when CacheException is thrown', () {
      // Arrange
      when(
        () => mockLocal.getFavorites(),
      ).thenThrow(const CacheException(message: 'read error'));

      // Act
      final result = repository.getFavorites();

      // Assert
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return empty list when no favorites are stored', () {
      // Arrange
      when(() => mockLocal.getFavorites()).thenReturn(<PokemonEntity>[]);

      // Act
      final result = repository.getFavorites();

      // Assert
      result.fold(
        (_) => fail('Expected Right'),
        (list) => expect(list, isEmpty),
      );
    });
  });

  // ─── isFavorite ───────────────────────────────────────────────────────────────

  group('isFavorite', () {
    test('should return true when pokemon is in favorites', () {
      // Arrange
      when(() => mockLocal.isFavorite(1)).thenReturn(true);

      // Act
      final result = repository.isFavorite(1);

      // Assert
      expect(result, isTrue);
      verify(() => mockLocal.isFavorite(1)).called(1);
      verifyNoMoreInteractions(mockLocal);
    });

    test('should return false when pokemon is not in favorites', () {
      // Arrange
      when(() => mockLocal.isFavorite(99)).thenReturn(false);

      // Act
      final result = repository.isFavorite(99);

      // Assert
      expect(result, isFalse);
      verify(() => mockLocal.isFavorite(99)).called(1);
      verifyNoMoreInteractions(mockLocal);
    });
  });
}
