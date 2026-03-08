import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('appName should be non-empty', () {
      expect(AppConstants.appName, isNotEmpty);
    });

    test('defaultPageSize should be 20', () {
      expect(AppConstants.defaultPageSize, 20);
    });

    test('favoritesStorageKey should be non-empty', () {
      expect(AppConstants.favoritesStorageKey, isNotEmpty);
    });

    test('maxFavorites should be 50', () {
      expect(AppConstants.maxFavorites, 50);
    });
  });
}
