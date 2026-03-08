import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract final class AppTextStyles {
  // ─── Headlines ────────────────────────────────────────────────────────────

  /// Nombre del Pokémon en pantalla de detalle (26 sp, medium) — mapea a [displayLarge].
  static final TextStyle headline1 = AppFonts.w500(
    size: 26,
    color: AppColors.textPrimary,
  );

  /// Nombre del Pokémon en la card de listado.
  static final TextStyle headline2 = AppFonts.w700(
    size: 21,
    color: AppColors.textPrimary,
  );

  /// Títulos de sección / AppBar (18 sp, semibold).

  static final TextStyle headline3 = AppFonts.w600(
    size: 18,
    color: AppColors.textPrimary,
  );

  // ─── Body ─────────────────────────────────────────────────────────────────

  /// Texto de cuerpo estándar (16 sp, regular).
  static final TextStyle bodyMedium = AppFonts.w400(
    size: 16,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  /// Texto de cuerpo pequeño / caption (14 sp, regular).

  static final TextStyle bodySmall = AppFonts.w400(
    size: 14,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ─── Labels ───────────────────────────────────────────────────────────────

  /// Label tiny usado dentro de chips y badges compactos.
  static final TextStyle labelSmall = AppFonts.w500(
    size: 10,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  // ─── Pokémon-specific ─────────────────────────────────────────────────────

  /// Número del Pokémon en la card de listado (#001) — 12 sp.
  static final TextStyle pokemonNumberDetail = AppFonts.w600(
    size: 12,
    color: AppColors.textSecondary,
  );

  /// Número del Pokémon en la pantalla de detalle (cuerpo blanco) — 16 sp.
  static final TextStyle pokemonDetailNumber = AppFonts.w600(
    size: 16,
    color: AppColors.textSecondary,
  );

  /// Nombre del Pokémon en la pantalla de detalle (cuerpo blanco) — 32 sp, bold.
  static final TextStyle pokemonDetailName = AppFonts.w700(
    size: 32,
    color: AppColors.textPrimary,
  );

  /// Nombre del Pokémon en la card de listado.
  static final TextStyle pokemonNameCard = AppFonts.w600(
    size: 21,
    color: AppColors.textPrimary,
  );

  /// Texto dentro de un [PokemonTypeChip] (11 sp, semibold, blanco).

  static final TextStyle typeChipText = AppFonts.w600(
    size: 11,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  // ─── Info del detalle (Peso, Altura, Categoría, Habilidad) ───────────────

  /// Etiqueta de info en mayúscula (PESO, ALTURA, CATEGORÍA, HABILIDAD).
  static final TextStyle infoLabel = AppFonts.w500(
    size: 12,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  /// Valor de info (6,9 kg, 0,7 m, SEMILLA, Espesura).
  static final TextStyle infoValue = AppFonts.w500(
    size: 18,
    color: AppColors.textPrimary,
  );

  /// Título de sección dentro de la pantalla de detalle (Debilidades, etc.).
  static final TextStyle sectionTitle = AppFonts.w700(
    size: 16,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ─── Stat bars ────────────────────────────────────────────────────────────

  /// Abreviatura del nombre del stat (HP, ATK, etc.).
  static final TextStyle statName = AppFonts.w600(
    size: 13,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  /// Valor numérico del stat.
  static final TextStyle statValue = AppFonts.w700(
    size: 13,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // ─── Empty states ─────────────────────────────────────────────────────────

  /// Título en pantallas de estado vacío o placeholder.
  static final TextStyle emptyStateTitle = AppFonts.w700(
    size: 20,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// Descripción en pantallas de estado vacío o placeholder.
  static final TextStyle emptyStateSubtitle = AppFonts.w400(
    size: 14,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ─── Search / Input ───────────────────────────────────────────────────────

  /// Hint del input de búsqueda.
  static final TextStyle searchHint = AppFonts.w400(
    size: 14,
    color: AppColors.disabled,
    height: 1.4,
  );

  /// Texto del contador de resultados ("Se han encontrado 3 resultados").
  static final TextStyle filterResult = AppFonts.w400(
    size: 13,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Texto del enlace "Borrar filtro".
  static final TextStyle clearFilter = AppFonts.w600(
    size: 13,
    color: AppColors.buttonPrimary,
    height: 1.4,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.buttonPrimary,
  );

  // ─── Buttons ──────────────────────────────────────────────────────────────

  /// Texto de botón primario
  static final TextStyle buttonText = AppFonts.w600(
    size: 18,
    color: AppColors.textOnPrimary,
  );

  /// Texto de botón secundario (Cancelar).
  static final TextStyle buttonSecondary = AppFonts.w600(
    size: 18,
    color: AppColors.textPrimary,
  );

  // ─── AppBar / Modal ───────────────────────────────────────────────────────

  /// Título del AppBar ("Favoritos").
  static final TextStyle appBarTitle = AppFonts.w600(
    size: 18,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// Título del modal/bottom sheet ("Filtra por tus preferencias").
  static final TextStyle modalTitle = AppFonts.w700(
    size: 18,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// Nombre de sección en el modal ("Tipo").
  static final TextStyle modalSection = AppFonts.w600(
    size: 16,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ─── Profile ──────────────────────────────────────────────────────────────

  /// Nombre del entrenador en el header de perfil (sobre fondo de color).
  static final TextStyle profileName = AppFonts.w700(
    size: 18,
    color: AppColors.textOnPrimary,
    height: 1.3,
  );
}
