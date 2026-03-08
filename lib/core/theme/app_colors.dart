import 'package:flutter/material.dart';

abstract final class AppColors {
  // ─── Background ───────────────────────────────────────────────────────────

  /// Fondo principal del scaffold — blanco puro.
  static const Color background = Color(0xFFFAFAFA);

  static const Color backgroundProfile = Color(0xFF1E88E5);

  /// Superficie secundaria — gris muy suave.
  static const Color surface = Color(0xFFF5F5F5);

  // ─── Text ─────────────────────────────────────────────────────────────────

  /// Texto principal — casi negro.
  static const Color textPrimary = Color(0xFF121212);

  /// Texto secundario — gris oscuro.
  static const Color textSecondary = Color(0xFF424242);

  /// Texto sobre superficies de color (cards de tipo, botones primarios).
  static const Color textOnPrimary = Color(0xFFFAFAFA);

  // ─── Shimmer ──────────────────────────────────────────────────────────────

  /// Color base del shimmer para skeletons.
  static const Color shimmerBase = Color(0xFFE0E0E0);

  /// Color highlight del shimmer para skeletons.
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // ─── Bordes y divisores ───────────────────────────────────────────────────

  /// Borde de inputs y contenedores de info (peso, altura, categoría).
  static const Color border = Color(0xFFE0E0E0);

  /// Divisores entre secciones.
  static const Color divider = Color(0xFFE8E8E8);

  // ─── Bottom Navigation ────────────────────────────────────────────────────

  /// Fondo de la barra de navegación inferior.
  static const Color navBarBackground = Color(0xFFFAFAFA);

  /// Ícono y label del tab activo en la barra de navegación, y fill del
  /// checkbox activo en el modal de filtros.
  ///
  ///
  static const Color navBarSelected = Color(0xFF1565C0);

  /// Ícono y label del tab inactivo en la barra de navegación.
  static const Color navBarUnselected = Color(0xFF424242);

  /// Alias de [border] para campos de entrada (mismo valor, semántica explícita).
  static const Color fieldBorder = border;

  /// Gris medio — hints, íconos desactivados, placeholders.
  static const Color disabled = Color(0xFF9E9E9E);

  // ─── Buttons ──────────────────────────────────────────────────────────────

  /// Fondo del botón primario.
  static const Color buttonPrimary = Color(0xFF1E88E5);

  /// Relleno gris claro del botón secundario / outlined.
  static const Color buttonSecondary = Color(0xFFEEEEEE);

  // ─── Feedback ─────────────────────────────────────────────────────────────

  /// Fondo de acciones destructivas (swipe-to-delete, alertas de error).
  static const Color danger = Color(0xFFCD3131);

  // ─── Onboarding ───────────────────────────────────────────────────────────

  /// Dot activo del indicador de página en onboarding.
  static const Color dotActive = Color(0xFF173EA5);

  // ─── Stat Bar ─────────────────────────────────────────────────────────────

  /// Barra de estadística baja (valor < 50) — rojo.
  static const Color statLow = Color(0xFFE53935);

  /// Barra de estadística media (50 ≤ valor < 80) — naranja.
  static const Color statMedium = Color(0xFFFB8C00);

  /// Barra de estadística alta (valor ≥ 80) — verde.
  static const Color statHigh = Color(0xFF43A047);

  static const Color refreshIndicator = buttonPrimary;
}
