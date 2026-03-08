import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/empty_state_widget.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: EmptyStateWidget(
          type: EmptyStateType.comingSoon,
          title: context.l10n.comingSoonTitle,
          subtitle: context.l10n.comingSoonDescription,
        ),
      ),
    );
  }
}
