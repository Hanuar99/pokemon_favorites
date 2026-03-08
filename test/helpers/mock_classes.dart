import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_favorites/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_favorites/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_favorites/features/pokemon/data/datasources/pokemon_local_datasource.dart';

/// Mock del contrato [PokemonRepository].
class MockPokemonRepository extends Mock implements PokemonRepository {}

/// Mock del contrato [PokemonRemoteDatasource].
class MockPokemonRemoteDatasource extends Mock
    implements PokemonRemoteDatasource {}

/// Mock del contrato [PokemonLocalDatasource].
class MockPokemonLocalDatasource extends Mock
    implements PokemonLocalDatasource {}

/// Mock de [Dio] para tests del datasource remoto.
class MockDio extends Mock implements Dio {}
