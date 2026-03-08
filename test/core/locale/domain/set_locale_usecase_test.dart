import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/core/locale/domain/locale_repository.dart';
import 'package:pokemon_favorites/core/locale/domain/set_locale_usecase.dart';

class _MockLocaleRepository extends Mock implements LocaleRepository {}

void main() {
  late SetLocaleUseCase useCase;
  late _MockLocaleRepository mockRepository;

  setUp(() {
    mockRepository = _MockLocaleRepository();
    useCase = SetLocaleUseCase(repository: mockRepository);
  });

  group('SetLocaleUseCase', () {
    test('should return Unit when locale is persisted successfully', () async {
      // Arrange
      when(() => mockRepository.setLanguageCode('en')).thenAnswer((_) async {});

      // Act
      final result = await useCase(const SetLocaleParams(languageCode: 'en'));

      // Assert
      expect(result, const Right<dynamic, Unit>(unit));
      verify(() => mockRepository.setLanguageCode('en')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return CacheFailure when repository throws', () async {
      // Arrange
      when(
        () => mockRepository.setLanguageCode('es'),
      ).thenThrow(Exception('write error'));

      // Act
      final result = await useCase(const SetLocaleParams(languageCode: 'es'));

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected Left(CacheFailure)'),
      );
      verify(() => mockRepository.setLanguageCode('es')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass the exact language code to repository', () async {
      // Arrange
      when(() => mockRepository.setLanguageCode('pt')).thenAnswer((_) async {});

      // Act
      await useCase(const SetLocaleParams(languageCode: 'pt'));

      // Assert
      verify(() => mockRepository.setLanguageCode('pt')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('SetLocaleParams', () {
    test('should support value equality', () {
      const p1 = SetLocaleParams(languageCode: 'es');
      const p2 = SetLocaleParams(languageCode: 'es');

      expect(p1, p2);
    });

    test('should not be equal when language code differs', () {
      const p1 = SetLocaleParams(languageCode: 'es');
      const p2 = SetLocaleParams(languageCode: 'en');

      expect(p1, isNot(p2));
    });
  });
}
