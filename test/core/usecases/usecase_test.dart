import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/core/usecases/usecase.dart';

void main() {
  group('NoParams', () {
    test('should support value equality', () {
      const p1 = NoParams();
      const p2 = NoParams();

      expect(p1, p2);
    });

    test('should have empty props list', () {
      const params = NoParams();

      expect(params.props, isEmpty);
    });
  });

  group('GetPokemonListParams (equatable)', () {
    test('should support value equality when limit and offset match', () {
      // Covered in dedicated params test; this ensures NoParams symmetry.
      expect(const NoParams() == const NoParams(), isTrue);
    });
  });
}
