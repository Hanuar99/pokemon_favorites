import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokemon_favorites/core/locale/data/locale_repository_impl.dart';

void main() {
  late LocaleRepositoryImpl repository;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = LocaleRepositoryImpl(prefs);
  });

  group('LocaleRepositoryImpl', () {
    test('should return default language code "es" when key is absent', () {
      // Act
      final result = repository.getLanguageCode();

      // Assert
      expect(result, 'es');
    });

    test(
      'should return persisted language code after setLanguageCode',
      () async {
        // Arrange
        await repository.setLanguageCode('en');

        // Act
        final result = repository.getLanguageCode();

        // Assert
        expect(result, 'en');
      },
    );

    test('should write language code to SharedPreferences', () async {
      // Act
      await repository.setLanguageCode('pt');

      // Assert
      expect(prefs.getString('locale_language_code'), 'pt');
    });

    test('should overwrite existing language code', () async {
      // Arrange
      await repository.setLanguageCode('en');

      // Act
      await repository.setLanguageCode('es');
      final result = repository.getLanguageCode();

      // Assert
      expect(result, 'es');
    });
  });
}
