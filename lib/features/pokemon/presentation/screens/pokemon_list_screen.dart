import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_favorites/core/theme/app_border_radius.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../providers/pokemon_list_provider.dart';
import '../providers/pokemon_search_provider.dart';
import '../providers/pokemon_type_filter_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/skeleton_pokemon_card.dart';
import 'filter_bottom_sheet.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= max * 0.9) {
      ref.read(pokemonListProvider.notifier).loadMore();
    }
  }

  List<PokemonEntity> _applyFilters({
    required List<PokemonEntity> list,
    required String query,
    required Set<String> types,
  }) {
    var result = list;

    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      result = result.where((p) {
        return p.name.toLowerCase().contains(q) || p.id.toString().contains(q);
      }).toList();
    }

    if (types.isNotEmpty) {
      result = result
          .where((p) => p.types.any((t) => types.contains(t.toLowerCase())))
          .toList();
    }

    return result;
  }

  void _clearFilters() {
    _searchController.clear();
    ref.read(pokemonSearchProvider.notifier).clear();
    ref.read(pokemonTypeFilterProvider.notifier).clearFilters();
  }

  void _showFilter() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.bottomSheet,
      ),
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(pokemonListProvider);
    final query = ref.watch(pokemonSearchProvider);
    final types = ref.watch(pokemonTypeFilterProvider);
    final hasActiveFilter = query.isNotEmpty || types.isNotEmpty;
    final filteredCount = listState.asData?.value != null
        ? _applyFilters(
            list: listState.asData!.value,
            query: query,
            types: types,
          ).length
        : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.searchBarTopSpacing),

              // ─── Barra de búsqueda + botón de filtro ────────
              if (!listState.hasError) ...[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppDimensions.searchBarHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.fieldBorder),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (v) => ref
                              .read(pokemonSearchProvider.notifier)
                              .updateSearch(v),
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: context.l10n.searchHint,
                            hintStyle: AppTextStyles.searchHint,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.disabled,
                              size: AppDimensions.iconMd,
                            ),
                            suffixIcon: query.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: AppColors.textSecondary,
                                      size: AppDimensions.iconClear,
                                    ),
                                    onPressed: _clearFilters,
                                  )
                                : null,

                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _SearchFilterButton(onTap: _showFilter),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // ─── Indicador de filtro activo ─────────────────
                if (hasActiveFilter)
                  _ActiveFilterBar(
                    onClear: _clearFilters,
                    resultCount: filteredCount,
                  ),
              ],

              // ─── Contenido ──────────────────────────────────
              Expanded(
                child: listState.when(
                  loading: () =>
                      const _LoadingSkeleton(key: ValueKey('loading')),
                  error: (_, _) => EmptyStateWidget(
                    key: const ValueKey('error'),
                    type: EmptyStateType.error,
                    title: context.l10n.errorTitle,
                    subtitle: context.l10n.errorDescription,
                    actionLabel: context.l10n.retry,
                    onAction: () => ref.invalidate(pokemonListProvider),
                  ),
                  data: (all) {
                    final filtered = _applyFilters(
                      list: all,
                      query: query,
                      types: types,
                    );

                    if (filtered.isEmpty) {
                      return EmptyStateWidget(
                        key: const ValueKey('empty'),
                        type: EmptyStateType.error,
                        title: context.l10n.noResults,
                        subtitle: context.l10n.noResultsSubtitle,
                        actionLabel: context.l10n.clearFilter,
                        onAction: _clearFilters,
                      );
                    }

                    return RefreshIndicator(
                      key: const ValueKey('list'),
                      color: AppColors.refreshIndicator,
                      onRefresh: () async =>
                          ref.invalidate(pokemonListProvider),
                      child: _PokemonListView(
                        list: filtered,
                        scrollController: _scrollController,
                        hasMore: ref.read(pokemonListProvider.notifier).hasMore,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchFilterButton extends StatelessWidget {
  const _SearchFilterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.searchFilterButtonSize,
        height: AppDimensions.searchFilterButtonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(
          Icons.search,
          color: AppColors.disabled,
          size: AppDimensions.iconMd,
        ),
      ),
    );
  }
}

// ─── Indicador de filtro activo ───────────────────────────────────

class _ActiveFilterBar extends StatelessWidget {
  const _ActiveFilterBar({required this.onClear, this.resultCount});

  final VoidCallback onClear;
  final int? resultCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Text(
              resultCount != null
                  ? context.l10n.resultsFound(resultCount!)
                  : '',
              style: AppTextStyles.filterResult,
            ),
          ),
          GestureDetector(
            onTap: onClear,
            child: Text(
              context.l10n.clearFilter,
              style: AppTextStyles.clearFilter,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── ListView de Pokémon ─────────────────────────────────────────

class _PokemonListView extends StatelessWidget {
  const _PokemonListView({
    required this.list,
    required this.scrollController,
    required this.hasMore,
  });

  final List<PokemonEntity> list;
  final ScrollController scrollController;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: list.length + (hasMore ? 1 : 0),
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppSpacing.listItemSpacing),
      itemBuilder: (context, index) {
        if (index >= list.length) {
          return const AppLoadingWidget.inline();
        }
        return PokemonCard(pokemon: list[index]);
      },
    );
  }
}

// ─── Skeleton de carga inicial ────────────────────────────────────

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppSpacing.listItemSpacing),
      itemBuilder: (_, _) => const SkeletonPokemonCard(),
    );
  }
}
