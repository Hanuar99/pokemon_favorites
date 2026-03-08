import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _kTotalPages = 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onButtonTapped() async {
    if (_currentPage < _kTotalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final notifier = ref.read(onboardingProvider.notifier);
      await notifier.complete();
      if (mounted) context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
            vertical: 40,
          ),
          child: Column(
            children: [
              // ─── Páginas ──────────────────────────────────────────────────
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  children: [
                    _OnboardingPage(
                      image: Assets.images.onboarding.onboarding1,
                      title: l10n.onboardingTitle1,
                      subtitle: l10n.onboardingDesc1,
                    ),
                    _OnboardingPage(
                      image: Assets.images.onboarding.onboarding2,
                      title: l10n.onboardingTitle2,
                      subtitle: l10n.onboardingDesc2,
                    ),
                  ],
                ),
              ),

              // ─── Indicadores de página ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_kTotalPages, (index) {
                    final isActive = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      width: isActive
                          ? AppDimensions.pageIndicatorDotActive
                          : AppDimensions.pageIndicatorDot,
                      height: AppDimensions.pageIndicatorDot,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.dotActive
                            : AppColors.divider,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }),
                ),
              ),

              // ─── Botón principal ──────────────────────────────────────────
              AppPrimaryButton(
                label: _currentPage < _kTotalPages - 1
                    ? l10n.continueButton
                    : l10n.letsStartButton,
                onPressed: _onButtonTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final AssetGenImage image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image.image(fit: BoxFit.contain),
        const SizedBox(height: AppSpacing.lg),
        Text(
          title,
          style: theme.textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
