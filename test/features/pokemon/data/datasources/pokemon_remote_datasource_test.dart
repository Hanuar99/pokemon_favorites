import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/core/constants/api_constants.dart';
import 'package:pokemon_favorites/core/errors/exceptions.dart';
import 'package:pokemon_favorites/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_detail_model.dart';
import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_model.dart';

import '../../../../helpers/mock_classes.dart';

void main() {
  late PokemonRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = PokemonRemoteDatasourceImpl(dio: mockDio);
  });

  /// Lee un fixture JSON desde el sistema de archivos.
  Map<String, dynamic> loadFixture(String name) {
    final file = File('test/fixtures/$name');
    return json.decode(file.readAsStringSync()) as Map<String, dynamic>;
  }

  /// Crea una [Response] de Dio con el mapa JSON dado.
  Response<Map<String, dynamic>> okResponse(
    Map<String, dynamic> data,
    String path,
  ) {
    return Response<Map<String, dynamic>>(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  // ─── getPokemonList ───────────────────────────────────────────────────────────

  group('getPokemonList', () {
    test(
      'should return List<PokemonModel> enriched with detail data when response is 200',
      () async {
        // Arrange
        final listJson = loadFixture('pokemon_list_fixture.json');
        final detailJson = loadFixture('pokemon_detail_fixture.json');
        when(
          () => mockDio.get<Map<String, dynamic>>(
            ApiConstants.pokemonEndpoint,
            queryParameters: {'limit': 3, 'offset': 0},
          ),
        ).thenAnswer(
          (_) async => okResponse(listJson, ApiConstants.pokemonEndpoint),
        );
        for (final name in ['bulbasaur', 'ivysaur', 'venusaur']) {
          final endpoint = ApiConstants.pokemonDetailEndpoint(name);
          when(
            () => mockDio.get<Map<String, dynamic>>(endpoint),
          ).thenAnswer((_) async => okResponse(detailJson, endpoint));
        }

        // Act
        final result = await datasource.getPokemonList(limit: 3, offset: 0);

        // Assert
        expect(result, isA<List<PokemonModel>>());
        expect(result.length, 3);
        expect(result[0].name, 'bulbasaur');
        expect(result[1].name, 'ivysaur');
        expect(result[2].name, 'venusaur');
        expect(result[0].imageUrl, isNotEmpty);
        expect(result[0].types, isNotEmpty);
        verify(
          () => mockDio.get<Map<String, dynamic>>(
            ApiConstants.pokemonEndpoint,
            queryParameters: {'limit': 3, 'offset': 0},
          ),
        ).called(1);
        for (final name in ['bulbasaur', 'ivysaur', 'venusaur']) {
          verify(
            () => mockDio.get<Map<String, dynamic>>(
              ApiConstants.pokemonDetailEndpoint(name),
            ),
          ).called(1);
        }
        verifyNoMoreInteractions(mockDio);
      },
    );

    test('should throw ServerException when response data is null', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          ApiConstants.pokemonEndpoint,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonList(limit: 20, offset: 0),
        throwsA(isA<ServerException>()),
      );
    });

    test('should rethrow DioException on 404 status', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          ApiConstants.pokemonEndpoint,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
          ),
          requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonList(limit: 20, offset: 0),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            404,
          ),
        ),
      );
    });

    test('should rethrow DioException on 500 server error', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          ApiConstants.pokemonEndpoint,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
          ),
          requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonList(limit: 20, offset: 0),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });

    test('should rethrow DioException on connection timeout', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          ApiConstants.pokemonEndpoint,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: ApiConstants.pokemonEndpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonList(limit: 20, offset: 0),
        throwsA(
          isA<DioException>().having(
            (e) => e.type,
            'type',
            DioExceptionType.connectionTimeout,
          ),
        ),
      );
    });
  });

  // ─── getPokemonDetail ─────────────────────────────────────────────────────────

  group('getPokemonDetail', () {
    test('should return PokemonDetailModel when response is 200', () async {
      // Arrange
      final json = loadFixture('pokemon_detail_fixture.json');
      final endpoint = ApiConstants.pokemonDetailEndpoint('bulbasaur');
      when(
        () => mockDio.get<Map<String, dynamic>>(endpoint),
      ).thenAnswer((_) async => okResponse(json, endpoint));

      // Act
      final result = await datasource.getPokemonDetail('bulbasaur');

      // Assert
      expect(result, isA<PokemonDetailModel>());
      expect(result.id, 1);
      expect(result.name, 'bulbasaur');
      expect(result.height, 7);
      expect(result.weight, 69);
      expect(result.baseExperience, 64);
      expect(result.types.length, 2);
      expect(result.types[0].type.name, 'grass');
      expect(result.types[1].type.name, 'poison');
      expect(result.stats.length, 6);
      expect(result.abilities.length, 2);
      verify(() => mockDio.get<Map<String, dynamic>>(endpoint)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('should expose correct frontDefault via bestImageUrl', () async {
      // Arrange
      final json = loadFixture('pokemon_detail_fixture.json');
      final endpoint = ApiConstants.pokemonDetailEndpoint('bulbasaur');
      when(
        () => mockDio.get<Map<String, dynamic>>(endpoint),
      ).thenAnswer((_) async => okResponse(json, endpoint));

      // Act
      final result = await datasource.getPokemonDetail('bulbasaur');

      // Assert
      expect(
        result.cardImageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
    });

    test('should throw ServerException when response data is null', () async {
      // Arrange
      final endpoint = ApiConstants.pokemonDetailEndpoint('bulbasaur');
      when(() => mockDio.get<Map<String, dynamic>>(endpoint)).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: endpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonDetail('bulbasaur'),
        throwsA(isA<ServerException>()),
      );
    });

    test('should rethrow DioException on 404 not found', () async {
      // Arrange
      final endpoint = ApiConstants.pokemonDetailEndpoint('nonexistent');
      when(() => mockDio.get<Map<String, dynamic>>(endpoint)).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: endpoint),
          ),
          requestOptions: RequestOptions(path: endpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonDetail('nonexistent'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            404,
          ),
        ),
      );
    });

    test('should rethrow DioException on receive timeout', () async {
      // Arrange
      final endpoint = ApiConstants.pokemonDetailEndpoint('bulbasaur');
      when(() => mockDio.get<Map<String, dynamic>>(endpoint)).thenThrow(
        DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: endpoint),
        ),
      );

      // Act & Assert
      expect(
        () => datasource.getPokemonDetail('bulbasaur'),
        throwsA(
          isA<DioException>().having(
            (e) => e.type,
            'type',
            DioExceptionType.receiveTimeout,
          ),
        ),
      );
    });
  });
}
