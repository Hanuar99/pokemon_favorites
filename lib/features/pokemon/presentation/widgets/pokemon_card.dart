import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_favorites/core/widgets/app_loading_widget.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/pokemon_type_colors.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/utils/type_icon_resolver.dart';
import '../../domain/entities/pokemon_entity.dart';
import 'favorite_button.dart';
import 'pokemon_type_chip.dart';

class PokemonCard extends ConsumerStatefulWidget {
  const PokemonCard({
    required this.pokemon,
    this.heroTagPrefix = 'pokemon-image',
    super.key,
  });

  final PokemonEntity pokemon;
  final String heroTagPrefix;

  @override
  ConsumerState<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends ConsumerState<PokemonCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails _) => setState(() => _isPressed = true);
  void _onTapUp(TapUpDetails _) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types.first : '';
    final primaryTypeColor = primaryType.isNotEmpty
        ? PokemonTypeColors.getColor(primaryType)
        : AppColors.shimmerBase;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => context.push('/home/detail/${pokemon.name}', extra: pokemon),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: Duration(milliseconds: _isPressed ? 100 : 150),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.card,
            color: primaryTypeColor.withValues(alpha: 0.5),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: AppDimensions.cardImageAreaWidth,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    color: primaryTypeColor,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        TypeIconResolver.icon(
                          primaryType,
                          size: AppDimensions.cardTypeIconSize,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.18),
                            BlendMode.srcIn,
                          ),
                        ),
                        Hero(
                          tag: '${widget.heroTagPrefix}-${pokemon.id}',
                          child: CachedNetworkImage(
                            imageUrl: pokemon.imageUrl,
                            width: AppDimensions.cardPokemonImage,
                            height: AppDimensions.cardPokemonImage,
                            fit: BoxFit.contain,
                            placeholder: (_, _) => const AppLoadingWidget(),
                            errorWidget: (_, _, _) => const Icon(
                              Icons.catching_pokemon,
                              size: AppDimensions.cardPokemonImage,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ─── Text + chips ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.screenPadding,
                  top: AppSpacing.cardPadding,
                  bottom: AppSpacing.cardPadding,
                  right: 148,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pokémon number
                    Text(
                      context.l10n.pokemonNumber(
                        pokemon.id.toString().padLeft(3, '0'),
                      ),
                      style: AppTextStyles.pokemonNumberDetail,
                    ),

                    // Name
                    Text(
                      pokemon.name.capitalize(),
                      style: AppTextStyles.pokemonNameCard,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Type chips
                    Wrap(
                      spacing: 2,
                      runSpacing: AppSpacing.xs,
                      children: pokemon.types
                          .map((type) => PokemonTypeChip(typeName: type))
                          .toList(),
                    ),
                  ],
                ),
              ),

              // ─── Favourite button ────────────────────────────────
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: FavoriteButton(pokemon: pokemon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
