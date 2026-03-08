import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_response_model.dart';
import '../models/pokemon_model.dart';

abstract interface class PokemonRemoteDatasource {
  Future<List<PokemonModel>> getPokemonList({
    required int limit,
    required int offset,
  });
  Future<PokemonDetailModel> getPokemonDetail(String name);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  const PokemonRemoteDatasourceImpl({required this.dio});
  final Dio dio;

  @override
  Future<List<PokemonModel>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiConstants.pokemonEndpoint,
        queryParameters: {'limit': limit, 'offset': offset},
      );

      if (response.data == null) {
        throw const ServerException(
          message: 'Empty response from server.',
          statusCode: 500,
        );
      }

      final listResponse = PokemonListResponseModel.fromJson(response.data!);

      final details = await Future.wait(
        listResponse.results.map((item) => getPokemonDetail(item.name)),
      );

      return List<PokemonModel>.generate(listResponse.results.length, (i) {
        final item = listResponse.results[i];
        final detail = details[i];
        return PokemonModel(
          id: item.id,
          name: item.name,
          imageUrl: detail.cardImageUrl,
          types: detail.types.map((t) => t.type.name).toList(),
        );
      });
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail(String name) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiConstants.pokemonDetailEndpoint(name),
      );

      if (response.data == null) {
        throw const ServerException(
          message: 'Empty response from server.',
          statusCode: 500,
        );
      }

      return PokemonDetailModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    }
  }
}
