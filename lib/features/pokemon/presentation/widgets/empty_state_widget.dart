import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';

enum EmptyStateType { error, emptyFavorites, comingSoon }

class EmptyStateWidget extends StatelessWidget {
  /// Crea un [EmptyStateWidget].
  const EmptyStateWidget({
    required this.type,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
    this.imageSize = 180,
    super.key,
  });

  final EmptyStateType type;
  final String title;

  final String subtitle;

  final String? actionLabel;

  final VoidCallback? onAction;

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final imageAsset = switch (type) {
      EmptyStateType.error => Assets.placeholders.magikarpError,
      EmptyStateType.emptyFavorites => Assets.placeholders.magikarpError,
      EmptyStateType.comingSoon => Assets.placeholders.jigglypuffComingSoon,
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Ilustración ──────────────────────────────────────
            imageAsset.image(
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: AppSpacing.xl),

            // ─── Título ───────────────────────────────────────────
            Text(
              title,
              style: AppTextStyles.emptyStateTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),

            // ─── Subtítulo ────────────────────────────────────────
            Text(
              subtitle,
              style: AppTextStyles.emptyStateSubtitle,
              textAlign: TextAlign.center,
            ),

            // ─── Botón de acción (opcional) ───────────────────────
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              AppPrimaryButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
