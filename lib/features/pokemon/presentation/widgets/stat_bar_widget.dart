import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/l10n/pokemon_stat_l10n.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class StatBarWidget extends StatelessWidget {
  const StatBarWidget({
    required this.statName,
    required this.value,
    this.maxValue = 255,
    this.animationDelay = Duration.zero,
    super.key,
  });

  final String statName;
  final int value;

  final int maxValue;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    final label = translateStatName(context.l10n, statName);
    final barColor = _statColor(value);
    final fraction = (value / maxValue).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.statBarSpacing / 2,
      ),
      child: Row(
        children: [
          // ─── Name (fixed 110 px) ───────────────────────────────
          SizedBox(
            width: AppDimensions.statBarLabelWidth,
            child: Text(label, style: AppTextStyles.statName),
          ),

          // ─── Numeric value (40 px, right-aligned) ─────────
          SizedBox(
            width: AppDimensions.statBarValueWidth,
            child: Text(
              value.toString().padLeft(3, '0'),
              style: AppTextStyles.statValue,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // ─── Animated bar (takes remaining space) ─────────────
          Expanded(
            child: _AnimatedBar(
              fraction: fraction,
              color: barColor,
              delay: animationDelay,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the semantic bar color based on [value].
  static Color _statColor(int value) {
    if (value < 50) return AppColors.statLow;
    if (value < 80) return AppColors.statMedium;
    return AppColors.statHigh;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal animated bar widget
// ─────────────────────────────────────────────────────────────────────────────

/// Renders the progress track + fill with a delayed tween animation.
class _AnimatedBar extends StatefulWidget {
  const _AnimatedBar({
    required this.fraction,
    required this.color,
    required this.delay,
  });

  final double fraction;
  final Color color;
  final Duration delay;

  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _animate = true;
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted) setState(() => _animate = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: _animate ? widget.fraction : 0),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, animated, _) {
            return RepaintBoundary(
              child: Stack(
                children: [
                  // Track
                  Container(
                    height: AppDimensions.statBarHeight,
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: AppBorderRadius.statBar,
                    ),
                  ),
                  // Fill
                  Container(
                    height: AppDimensions.statBarHeight,
                    width: maxWidth * animated,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: AppBorderRadius.statBar,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
