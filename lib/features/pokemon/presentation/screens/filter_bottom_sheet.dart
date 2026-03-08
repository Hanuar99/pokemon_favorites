import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/l10n/pokemon_type_l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../providers/pokemon_type_filter_provider.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late Set<String> _tempSelected;

  static const List<String> _apiTypes = [
    'steel',
    'water',
    'bug',
    'dragon',
    'electric',
    'ghost',
    'fire',
    'fairy',
    'ice',
    'fighting',
    'normal',
    'grass',
    'psychic',
    'rock',
    'dark',
    'ground',
    'poison',
    'flying',
  ];

  @override
  void initState() {
    super.initState();
    _tempSelected = Set<String>.from(ref.read(pokemonTypeFilterProvider));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── Header ─────────────────────────────────────
              Center(
                child: Text(
                  context.l10n.filterTitle,
                  style: AppTextStyles.modalTitle,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // ─── Etiqueta sección ────────────────────────────
              Row(
                children: [
                  Text(
                    context.l10n.filterType,
                    style: AppTextStyles.modalSection,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              const Divider(height: 1, color: AppColors.divider),

              // ─── Lista de tipos ──────────────────────────────
              Expanded(
                child: ListView.builder(
                  controller: scrollController,

                  itemCount: _apiTypes.length,
                  itemBuilder: (_, i) {
                    final apiName = _apiTypes[i];
                    final label = translatePokemonType(context.l10n, apiName);
                    final isSelected = _tempSelected.contains(apiName);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _tempSelected.remove(apiName);
                          } else {
                            _tempSelected.add(apiName);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.lg,
                        ),
                        child: Row(
                          children: [
                            Text(
                              label,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: AppDimensions.filterCheckboxSize,
                              height: AppDimensions.filterCheckboxSize,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.buttonPrimary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.buttonPrimary
                                      : AppColors.textSecondary,
                                  width:
                                      AppDimensions.filterCheckboxBorderWidth,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: AppDimensions.filterCheckIconSize,
                                      color: AppColors.textOnPrimary,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              const Divider(height: 1, color: AppColors.divider),
              const SizedBox(height: AppSpacing.lg),

              // ─── Botones ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: Column(
                  children: [
                    AppPrimaryButton(
                      label: context.l10n.applyFilter,
                      onPressed: () {
                        ref
                            .read(pokemonTypeFilterProvider.notifier)
                            .setFilters(_tempSelected);
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonSecondaryHeight,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),

                        child: Text(
                          context.l10n.cancelFilter,
                          style: AppTextStyles.buttonSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
