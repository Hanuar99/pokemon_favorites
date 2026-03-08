import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_favorites/core/utils/type_icon_resolver.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/pokemon_type_colors.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../providers/pokemon_detail_provider.dart';
import '../widgets/favorite_button.dart';
import '../widgets/pokemon_type_chip.dart';
import '../widgets/stat_bar_widget.dart';

class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({required this.pokemon, super.key});

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryTypeColor = pokemon.types.isNotEmpty
        ? PokemonTypeColors.getColor(pokemon.types.first)
        : AppColors.shimmerBase;

    final detailAsync = ref.watch(pokemonDetailProvider(pokemon.name));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryTypeColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.textOnPrimary,
            size: AppDimensions.backArrowSize,
          ),
        ),
        actions: [
          if (detailAsync.hasValue)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FavoriteButton(
                pokemon: pokemon,
                size: AppDimensions.iconXl,
                useMaterialIcon: true,
              ),
            ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const AppLoadingWidget(),
        error: (_, _) => const SizedBox.shrink(),
        data: (detail) => Column(
          children: [
            // ─── Header fijo  ────────────────────
            _HeaderBackground(
              pokemon: detail,
              primaryTypeColor: primaryTypeColor,
            ),

            // ─── Contenido scrolleable ────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: _DetailBody(pokemon: pokemon, detail: detail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  const _HeaderBackground({
    required this.pokemon,
    required this.primaryTypeColor,
  });

  final PokemonDetailEntity pokemon;
  final Color primaryTypeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.detailHeaderRawHeight - kToolbarHeight,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -227 - kToolbarHeight,
            child: Container(
              width: AppDimensions.detailCircleSize,
              height: AppDimensions.detailCircleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryTypeColor,
              ),
            ),
          ),

          // ─── Pokéball de fondo ──────────────────────────
          Positioned(
            top: 0,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.textOnPrimary.withValues(alpha: 0.8),
                  AppColors.textOnPrimary.withValues(alpha: 0.1),
                ],
              ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: TypeIconResolver.icon(
                pokemon.types.isNotEmpty ? pokemon.types.first : '',
                size: AppDimensions.detailTypeIconSize,
                colorFilter: ColorFilter.mode(
                  AppColors.textOnPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // ─── Imagen del Pokémon ────────────────────────
          Positioned(
            bottom: 0,
            child: Hero(
              tag: 'pokemon-image-${pokemon.id}',
              flightShuttleBuilder: (_, animation, _, _, toHeroContext) =>
                  FadeTransition(
                    opacity: animation,
                    child: toHeroContext.widget,
                  ),
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                width: AppDimensions.detailPokemonImageWidth,
                height: AppDimensions.detailPokemonImageHeight,
                fit: BoxFit.contain,
                errorWidget: (_, _, _) => const Icon(
                  Icons.catching_pokemon,
                  size: AppDimensions.detailFallbackIconSize,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.pokemon, required this.detail});

  final PokemonEntity pokemon;
  final PokemonDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Nombre ──────────────────────────────────────────
          Text(
            pokemon.name.capitalize(),
            style: AppTextStyles.pokemonDetailName,
          ),

          // ─── Número ──────────────────────────────────────────
          Text(
            'Nº${pokemon.id.toString().padLeft(3, '0')}',
            style: AppTextStyles.pokemonDetailNumber,
          ),
          const SizedBox(height: AppSpacing.xl),

          // ─── Tipos ───────────────────────────────────────────
          Wrap(
            spacing: AppSpacing.chipSpacing,
            runSpacing: AppSpacing.xs,
            children: detail.types
                .map((t) => PokemonTypeChip(typeName: t))
                .toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          Divider(color: AppColors.divider),

          const SizedBox(height: AppSpacing.lg),

          // ───  Peso · Altura · Exp. Base · Habilidad ─
          _InfoGrid(detail: detail),

          const SizedBox(height: AppSpacing.lg),

          // ─── Estadísticas base ────────────────────────────────
          if (detail.stats.isNotEmpty) ...[
            Text(context.l10n.baseStats, style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            ...detail.stats.asMap().entries.map(
              (entry) => StatBarWidget(
                statName: entry.value.statName,
                value: entry.value.baseStat,
                animationDelay: Duration(milliseconds: entry.key * 80),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.detail});

  final PokemonDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoCell(
                icon: Icons.scale_outlined,
                label: context.l10n.weight.toUpperCase(),
                value: '${detail.weightInKg.toStringAsFixed(1)} kg',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _InfoCell(
                icon: Icons.straighten_outlined,
                label: context.l10n.height.toUpperCase(),
                value: '${detail.heightInMeters.toStringAsFixed(1)} m',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _InfoCell(
                icon: Icons.auto_awesome_outlined,
                label: context.l10n.baseExperience.toUpperCase(),
                value: '${detail.baseExperience}',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _InfoCell(
                icon: Icons.face_outlined,
                label: context.l10n.ability.toUpperCase(),
                value: detail.abilities.isNotEmpty
                    ? detail.abilities.first.capitalize()
                    : '—',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconXs,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(label, style: AppTextStyles.infoLabel)),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppBorderRadius.md,
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            value.capitalize(),
            style: AppTextStyles.infoValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
