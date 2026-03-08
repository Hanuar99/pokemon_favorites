import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'coming_soon_screen.dart';
import 'favorites_screen.dart';
import 'pokemon_list_screen.dart';
import 'profile_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    PokemonListScreen(),
    ComingSoonScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: AppBorderRadius.navBar,
          boxShadow: [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 3,
              spreadRadius: 0,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: AppBorderRadius.navBar,
          child: Container(
            padding: const EdgeInsets.only(
              top: AppSpacing.lg,
              bottom: AppSpacing.lg,
              left: AppSpacing.md,
              right: AppSpacing.md,
            ),
            decoration: const BoxDecoration(
              color: AppColors.navBarBackground,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                  label: context.l10n.tabPokedex,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.language_outlined),
                  activeIcon: const Icon(Icons.language),
                  label: context.l10n.tabRegions,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_outline),
                  activeIcon: const Icon(Icons.favorite),
                  label: context.l10n.tabFavorites,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline_rounded),
                  activeIcon: const Icon(Icons.person_rounded),
                  label: context.l10n.tabProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
