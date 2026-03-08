import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/features/pokemon/domain/usecases/get_pokemon_list_params.dart';

void main() {
  group('GetPokemonListParams', () {
    test('should support value equality', () {
      const p1 = GetPokemonListParams(limit: 20, offset: 0);
      const p2 = GetPokemonListParams(limit: 20, offset: 0);

      expect(p1, p2);
    });

    test('should not be equal when limit differs', () {
      const p1 = GetPokemonListParams(limit: 10, offset: 0);
      const p2 = GetPokemonListParams(limit: 20, offset: 0);

      expect(p1, isNot(p2));
    });

    test('should not be equal when offset differs', () {
      const p1 = GetPokemonListParams(limit: 20, offset: 0);
      const p2 = GetPokemonListParams(limit: 20, offset: 20);

      expect(p1, isNot(p2));
    });

    test('default constructor should set limit=20 and offset=0', () {
      const params = GetPokemonListParams();

      expect(params.limit, 20);
      expect(params.offset, 0);
    });

    test('props should contain limit and offset', () {
      const params = GetPokemonListParams(limit: 5, offset: 10);

      expect(params.props, [5, 10]);
    });
  });
}
