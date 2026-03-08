import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_border_radius.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      textTheme: AppFonts.textTheme
          .apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          )
          .copyWith(
            displayLarge: AppTextStyles.headline1,
            displayMedium: AppTextStyles.headline2,
            displaySmall: AppTextStyles.headline3,
            bodyLarge: AppTextStyles.bodyMedium,
            bodyMedium: AppTextStyles.bodySmall,
            labelSmall: AppTextStyles.labelSmall,
          ),

      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.appBarTitle,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBarBackground,
        selectedItemColor: AppColors.navBarSelected,
        unselectedItemColor: AppColors.navBarUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppFonts.w700(size: 10),
        unselectedLabelStyle: AppFonts.w500(size: 10),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.navBarSelected
              : null,
        ),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
      ),

      // ─── Campo de entrada ──────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hintStyle: AppTextStyles.searchHint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.input,
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.input,
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.input,
          borderSide: const BorderSide(
            color: AppColors.buttonPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(borderRadius: AppBorderRadius.input),
      ),

      // ─── Botón elevado ─────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.textOnPrimary,
          textStyle: AppTextStyles.buttonText,
          shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.button),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      // ─── Botón outlined ────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.buttonSecondary,
          foregroundColor: AppColors.textPrimary,
          textStyle: AppTextStyles.buttonSecondary,
          side: const BorderSide(color: AppColors.buttonSecondary),
          shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.button),
        ),
      ),
    );
  }
}
