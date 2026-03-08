import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/onboarding_provider.dart';
import '../widgets/pokeball_loading.dart';
import '../../../../core/theme/app_dimensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _scaleController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Ambas animaciones arrancan en paralelo.
    _fadeController.forward();
    _scaleController.forward();

    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    final delayFuture = Future.delayed(const Duration(milliseconds: 2500));
    final isCompletedFuture = ref.read(isOnboardingCompletedProvider.future);

    final isCompleted = await isCompletedFuture;
    await delayFuture;

    if (!mounted) return;
    context.go(isCompleted ? '/home' : '/onboarding');
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const PokeballLoading(
                    size: AppDimensions.splashPokeballSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
