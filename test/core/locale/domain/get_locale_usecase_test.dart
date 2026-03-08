import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/core/locale/domain/get_locale_usecase.dart';
import 'package:pokemon_favorites/core/locale/domain/locale_repository.dart';
import 'package:pokemon_favorites/core/usecases/usecase.dart';

class _MockLocaleRepository extends Mock implements LocaleRepository {}

void main() {
  late GetLocaleUseCase useCase;
  late _MockLocaleRepository mockRepository;

  setUp(() {
    mockRepository = _MockLocaleRepository();
    useCase = GetLocaleUseCase(repository: mockRepository);
  });

  group('GetLocaleUseCase', () {
    test('should return language code when repository succeeds', () {
      // Arrange
      when(() => mockRepository.getLanguageCode()).thenReturn('es');

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, String>('es'));
      verify(() => mockRepository.getLanguageCode()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return English code when locale is set to en', () {
      // Arrange
      when(() => mockRepository.getLanguageCode()).thenReturn('en');

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, String>('en'));
      verify(() => mockRepository.getLanguageCode()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return CacheFailure when repository throws', () {
      // Arrange
      when(
        () => mockRepository.getLanguageCode(),
      ).thenThrow(Exception('read error'));

      // Act
      final result = useCase(const NoParams());

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected Left(CacheFailure)'),
      );
      verify(() => mockRepository.getLanguageCode()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
