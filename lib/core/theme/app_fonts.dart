import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppFonts {
  AppFonts._();

  /// Poppins Regular (w400).
  static TextStyle w400({
    required double size,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  /// Poppins Medium (w500).
  static TextStyle w500({
    required double size,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  /// Poppins SemiBold (w600).
  static TextStyle w600({
    required double size,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  /// Poppins Bold (w700).
  static TextStyle w700({
    required double size,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  static final TextTheme textTheme = GoogleFonts.poppinsTextTheme();
}
