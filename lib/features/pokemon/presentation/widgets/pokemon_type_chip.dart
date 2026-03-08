import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/l10n/pokemon_type_l10n.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/pokemon_type_colors.dart';
import '../../../../core/utils/type_icon_resolver.dart';

class PokemonTypeChip extends StatelessWidget {
  const PokemonTypeChip({required this.typeName, super.key});

  final String typeName;

  @override
  Widget build(BuildContext context) {
    final typeColor = PokemonTypeColors.getColor(typeName);
    final iconSize = 20.0;
    final label = translatePokemonType(context.l10n, typeName);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.chipSpacing,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: AppBorderRadius.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(AppSpacing.xs),
            child: Center(
              child: TypeIconResolver.icon(
                typeName,
                colorFilter: ColorFilter.mode(typeColor, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.xs),

          // ─── Label (i18n) ──────────────────────────────────────
          Text(
            label,
            style: (AppTextStyles.typeChipText).copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
