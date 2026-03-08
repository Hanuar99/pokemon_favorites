import 'package:flutter/material.dart';

import '../../features/pokemon/presentation/widgets/pokeball_loading.dart';
import '../theme/app_spacing.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({this.size = 80, super.key});

  const AppLoadingWidget.inline({super.key}) : size = 40;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: PokeballLoading(size: size)),
    );
  }
}
