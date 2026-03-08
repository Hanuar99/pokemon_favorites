import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_favorites/core/gen/assets.gen.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../providers/favorites_provider.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton({
    required this.pokemon,
    this.size = 32,
    this.useMaterialIcon = false,
    super.key,
  });

  final PokemonEntity pokemon;
  final double size;

  /// Si es true, usa Icons.favorite / Icons.favorite_border en lugar del SVG asset.
  final bool useMaterialIcon;

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  /// Controlador del rebote 1.0 → 0.75 → 1.0.
  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // TweenSequence: 50 % del tiempo baja a 0.75, 50 % vuelve a 1.0.
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.75,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.75,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
    ]).animate(_bounceController);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    // Dispara el rebote y luego toggle.
    await _bounceController.forward(from: 0);
    if (mounted) {
      ref.read(favoritesProvider.notifier).toggleFavorite(widget.pokemon);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(
      favoritesProvider.select(
        (list) => list.any((p) => p.id == widget.pokemon.id),
      ),
    );

    return Semantics(
      label: context.l10n.semanticFavoriteButton(
        widget.pokemon.name.capitalize(),
      ),
      button: true,
      toggled: isFavorite,
      child: RepaintBoundary(
        child: GestureDetector(
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: ScaleTransition(
            scale: _bounceAnimation,
            child: widget.useMaterialIcon
                ? SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: _buildIcon(isFavorite),
                  )
                : Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.65),
                      shape: BoxShape.circle,
                    ),
                    child: _buildIcon(isFavorite),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isFavorite) {
    if (widget.useMaterialIcon) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: child,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          color: AppColors.textOnPrimary,
          size: widget.size,
        ),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        ),
        child: child,
      ),
      child: isFavorite
          ? Assets.icons.favoriteActive.svg(key: const ValueKey('active'))
          : Assets.icons.favoriteInactive.svg(key: const ValueKey('inactive')),
    );
  }
}
