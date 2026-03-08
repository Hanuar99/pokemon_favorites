import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokemon_favorites/features/pokemon/data/repositories/onboarding_repository_impl.dart';

void main() {
  late OnboardingRepositoryImpl repository;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = OnboardingRepositoryImpl(prefs);
  });

  group('OnboardingRepositoryImpl', () {
    test(
      'should return false when onboarding key is absent in SharedPreferences',
      () async {
        // Act
        final result = await repository.isOnboardingCompleted();

        // Assert
        expect(result, isFalse);
      },
    );

    test('should return true after completing onboarding', () async {
      // Arrange
      await repository.completeOnboarding();

      // Act
      final result = await repository.isOnboardingCompleted();

      // Assert
      expect(result, isTrue);
    });

    test('should persist the onboarding flag in SharedPreferences', () async {
      // Act
      await repository.completeOnboarding();

      // Assert
      expect(prefs.getBool('onboarding_completed'), isTrue);
    });

    test(
      'should return false after setMockInitialValues is reset without the key',
      () async {
        // Arrange — reaplicar sin el flag
        SharedPreferences.setMockInitialValues({});
        final freshPrefs = await SharedPreferences.getInstance();
        final freshRepo = OnboardingRepositoryImpl(freshPrefs);

        // Act
        final result = await freshRepo.isOnboardingCompleted();

        // Assert
        expect(result, isFalse);
      },
    );
  });
}
