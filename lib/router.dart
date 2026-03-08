import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'features/pokemon/presentation/screens/onboarding_screen.dart';
import 'features/pokemon/domain/entities/pokemon_entity.dart';
import 'features/pokemon/presentation/screens/splash_screen.dart';
import 'features/pokemon/presentation/screens/main_shell_screen.dart';
import 'features/pokemon/presentation/screens/pokemon_detail_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainShellScreen(),
        routes: [
          GoRoute(
            path: 'detail/:name',
            name: 'pokemon-detail',
            pageBuilder: (context, state) {
              final pokemon = state.extra! as PokemonEntity;
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: PokemonDetailScreen(pokemon: pokemon),
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
        ],
      ),
    ],
  );
}

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}
