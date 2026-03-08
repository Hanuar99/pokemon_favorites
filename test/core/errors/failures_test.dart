import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_favorites/core/errors/failures.dart';

void main() {
  group('Failure sealed class', () {
    test('ServerFailure should support value equality', () {
      // Arrange
      const f1 = Failure.server(message: 'error', statusCode: 500);
      const f2 = Failure.server(message: 'error', statusCode: 500);

      // Assert
      expect(f1, f2);
    });

    test('NetworkFailure should support value equality', () {
      const f1 = Failure.network(message: 'no internet');
      const f2 = Failure.network(message: 'no internet');

      expect(f1, f2);
    });

    test('CacheFailure should support value equality', () {
      const f1 = Failure.cache(message: 'cache error');
      const f2 = Failure.cache(message: 'cache error');

      expect(f1, f2);
    });

    test('UnknownFailure should support value equality', () {
      const f1 = Failure.unknown(message: 'unexpected');
      const f2 = Failure.unknown(message: 'unexpected');

      expect(f1, f2);
    });

    test('different failure types with same message should not be equal', () {
      const server = Failure.server(message: 'error', statusCode: 500);
      const network = Failure.network(message: 'error');

      expect(server, isNot(network));
    });

    test('ServerFailure should carry statusCode', () {
      const failure = Failure.server(message: 'Not Found', statusCode: 404);

      expect((failure as ServerFailure).statusCode, 404);
      expect(failure.message, 'Not Found');
    });
  });
}
