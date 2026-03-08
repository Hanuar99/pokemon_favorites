import 'package:equatable/equatable.dart';

final class GetPokemonListParams extends Equatable {
  const GetPokemonListParams({this.limit = 20, this.offset = 0});
  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}
