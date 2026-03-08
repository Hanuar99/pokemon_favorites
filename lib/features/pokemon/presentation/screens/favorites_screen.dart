import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/favorites_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/pokemon_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    if (favorites.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: EmptyStateWidget(
          type: EmptyStateType.emptyFavorites,
          title: context.l10n.noFavoritesTitle,
          subtitle: context.l10n.noFavoritesSubtitle,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.only(
            top: AppSpacing.md,
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
          ),
          itemCount: favorites.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppSpacing.listItemSpacing),
          itemBuilder: (context, index) {
            final pokemon = favorites[index];
            return ClipRRect(
              borderRadius: AppBorderRadius.card,
              child: Dismissible(
                key: ValueKey('fav-${pokemon.id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(pokemon),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  color: AppColors.danger,
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColors.textOnPrimary,
                    size: AppDimensions.deleteIconSize,
                  ),
                ),
                child: PokemonCard(
                  pokemon: pokemon,
                  heroTagPrefix: 'fav-pokemon-image',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
