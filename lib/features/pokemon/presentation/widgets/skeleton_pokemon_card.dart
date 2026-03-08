import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class SkeletonPokemonCard extends StatelessWidget {
  const SkeletonPokemonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppBorderRadius.card,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.cardPadding,
            top: AppSpacing.cardPadding,
            bottom: AppSpacing.cardPadding,
            right: AppSpacing.cardPadding + 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Number placeholder
              _ShimmerBox(width: 52, height: 13, radius: AppBorderRadius.xs),
              const SizedBox(height: AppSpacing.sm),

              // Name placeholder
              _ShimmerBox(width: 140, height: 22, radius: AppBorderRadius.xs),
              const SizedBox(height: AppSpacing.sm),

              // Type chips placeholders
              Row(
                children: [
                  _ShimmerBox(
                    width: 72,
                    height: 24,
                    radius: AppBorderRadius.chip,
                  ),
                  const SizedBox(width: AppSpacing.chipSpacing),
                  _ShimmerBox(
                    width: 72,
                    height: 24,
                    radius: AppBorderRadius.chip,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Internal helper: a solid white rounded box for shimmer areas.
class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.radius,
  });

  final double width;
  final double height;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: radius),
    );
  }
}
