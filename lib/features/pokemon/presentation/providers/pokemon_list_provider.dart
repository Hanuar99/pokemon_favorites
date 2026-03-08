import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon_list_params.dart';
import '../../di/pokemon_module.dart';

part 'pokemon_list_provider.g.dart';

@riverpod
class PokemonList extends _$PokemonList {
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  @override
  Future<List<PokemonEntity>> build() async {
    _offset = 0;
    _hasMore = true;
    _isLoadingMore = false;
    return _fetchPage(0);
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    final currentList = state.asData?.value ?? [];
    _isLoadingMore = true;

    final newOffset = _offset + AppConstants.defaultPageSize;
    final useCase = await ref.read(getPokemonListUseCaseProvider.future);

    final result = await useCase(
      GetPokemonListParams(
        limit: AppConstants.defaultPageSize,
        offset: newOffset,
      ),
    );

    result.fold(
      (failure) {
        _isLoadingMore = false;

        state = AsyncError(failure, StackTrace.current);
      },
      (newItems) {
        _offset = newOffset;
        _isLoadingMore = false;

        if (newItems.length < AppConstants.defaultPageSize) {
          _hasMore = false;
        }

        state = AsyncData([...currentList, ...newItems]);
      },
    );
  }

  Future<List<PokemonEntity>> _fetchPage(int offset) async {
    final useCase = await ref.read(getPokemonListUseCaseProvider.future);

    final result = await useCase(
      GetPokemonListParams(limit: AppConstants.defaultPageSize, offset: offset),
    );

    return result.fold(
      (failure) => throw _FailureException(failure.toString()),
      (items) {
        if (items.length < AppConstants.defaultPageSize) {
          _hasMore = false;
        }
        _offset = offset;
        return items;
      },
    );
  }
}

class _FailureException extends Error {
  _FailureException(this.message);

  final String message;

  @override
  String toString() => message;
}
