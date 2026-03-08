import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _ProfileHeader(locale: locale),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSpacing.xl),
                _SettingsSection(locale: locale),
                const SizedBox(height: AppSpacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppDimensions.profileHeaderHeight,
      pinned: true,
      backgroundColor: AppColors.backgroundProfile,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: AppColors.backgroundProfile),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.lg),
                Container(
                  width: AppDimensions.profileAvatarSize,
                  height: AppDimensions.profileAvatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background,
                    border: Border.all(
                      color: AppColors.textOnPrimary,
                      width: AppDimensions.profileAvatarBorderWidth,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.catching_pokemon,
                    size: AppDimensions.profileAvatarIconSize,
                    color: AppColors.backgroundProfile,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.profileTrainerName,
                  style: AppTextStyles.profileName,
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: AppBorderRadius.chip,
                  ),
                  child: Text(
                    context.l10n.profileTrainerSubtitle,
                    style: AppTextStyles.labelSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Settings ─────────────────────────────────────────────────────────────────

class _SettingsSection extends ConsumerWidget {
  const _SettingsSection({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.profileSettingsTitle, style: AppTextStyles.headline3),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppBorderRadius.card,
            border: Border.all(color: AppColors.border),
          ),
          child: _SettingsTile(
            icon: Icons.language_rounded,
            iconColor: AppColors.backgroundProfile,
            title: context.l10n.profileLanguageTitle,
            subtitle: locale.languageCode == 'es'
                ? 'Español 🇪🇸'
                : 'English 🇺🇸',
            onTap: () => _showLanguageSheet(context, ref, locale),
          ),
        ),
      ],
    );
  }

  void _showLanguageSheet(BuildContext context, WidgetRef ref, Locale current) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.bottomSheet,
      ),
      builder: (_) => _LanguageBottomSheet(
        currentLocale: current,
        onSelect: (locale) {
          ref.read(localeProvider.notifier).setLocale(locale);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _LanguageBottomSheet extends StatelessWidget {
  const _LanguageBottomSheet({
    required this.currentLocale,
    required this.onSelect,
  });

  final Locale currentLocale;
  final void Function(Locale) onSelect;

  static const _options = [
    (locale: Locale('es'), label: 'Español', flag: '🇪🇸'),
    (locale: Locale('en'), label: 'English', flag: '🇺🇸'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimensions.dragHandleWidth,
              height: AppDimensions.dragHandleHeight,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: AppBorderRadius.xs,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              context.l10n.profileLanguageTitle,
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: AppSpacing.sm),
            ..._options.map(
              (opt) => ListTile(
                leading: Text(opt.flag, style: const TextStyle(fontSize: 26)),
                title: Text(opt.label, style: AppTextStyles.bodyMedium),
                trailing: currentLocale.languageCode == opt.locale.languageCode
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.backgroundProfile,
                      )
                    : null,
                onTap: () => onSelect(opt.locale),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared tile ─────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
      leading: Container(
        width: AppDimensions.settingIconContainer,
        height: AppDimensions.settingIconContainer,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppBorderRadius.sm,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: iconColor, size: AppDimensions.iconLg),
      ),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          : null,
      trailing: onTap != null
          ? const Icon(Icons.chevron_right_rounded, color: AppColors.disabled)
          : null,
      onTap: onTap,
    );
  }
}
