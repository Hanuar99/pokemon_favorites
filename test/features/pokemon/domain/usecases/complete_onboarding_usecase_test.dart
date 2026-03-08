import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/core/usecases/usecase.dart';
import 'package:pokemon_favorites/features/pokemon/domain/repositories/onboarding_repository.dart';
import 'package:pokemon_favorites/features/pokemon/domain/usecases/complete_onboarding_usecase.dart';

class _MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late CompleteOnboardingUseCase useCase;
  late _MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = _MockOnboardingRepository();
    useCase = CompleteOnboardingUseCase(repository: mockRepository);
  });

  group('CompleteOnboardingUseCase', () {
    test('should return Unit when onboarding completes successfully', () async {
      // Arrange
      when(() => mockRepository.completeOnboarding()).thenAnswer((_) async {});

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, const Right<dynamic, Unit>(unit));
      verify(() => mockRepository.completeOnboarding()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return CacheFailure when repository throws an exception',
      () async {
        // Arrange
        when(
          () => mockRepository.completeOnboarding(),
        ).thenThrow(Exception('write error'));

        // Act
        final result = await useCase(const NoParams());

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected a Left(CacheFailure)'),
        );
        verify(() => mockRepository.completeOnboarding()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
