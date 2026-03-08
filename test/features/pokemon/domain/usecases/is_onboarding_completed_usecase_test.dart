import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/core/usecases/usecase.dart';
import 'package:pokemon_favorites/features/pokemon/domain/repositories/onboarding_repository.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/is_onboarding_completed_usecase.dart';

class _MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late IsOnboardingCompletedUseCase useCase;
  late _MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = _MockOnboardingRepository();
    useCase = IsOnboardingCompletedUseCase(repository: mockRepository);
  });

  group('IsOnboardingCompletedUseCase', () {
    test('should return true when onboarding is completed', () async {
      // Arrange
      when(
        () => mockRepository.isOnboardingCompleted(),
      ).thenAnswer((_) async => true);

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, bool>(true));
      verify(() => mockRepository.isOnboardingCompleted()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return false when onboarding is not completed', () async {
      // Arrange
      when(
        () => mockRepository.isOnboardingCompleted(),
      ).thenAnswer((_) async => false);

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, bool>(false));
      verify(() => mockRepository.isOnboardingCompleted()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return CacheFailure when repository throws an exception',
      () async {
        // Arrange
        when(
          () => mockRepository.isOnboardingCompleted(),
        ).thenThrow(Exception('disk error'));

        // Act
        final result = await useCase(const NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected a Left(CacheFailure)'),
        );
        verify(() => mockRepository.isOnboardingCompleted()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
