import 'package:flutter/material.dart';

abstract final class AppBorderRadius {
  // ─── Valores numéricos base ───────────────────────────────────────────────

  /// 4 dp — rounding sutil para contenedores pequeños.
  static const double _xs = 4;

  /// 8 dp — componentes pequeños.
  static const double _sm = 8;

  /// 12 dp — contenedores de info (peso, altura, categoría).
  static const double _md = 12;

  /// 16 dp — cards de pokémon.
  static const double _lg = 16;

  /// 24 dp — bottom sheet, modal.
  static const double _xl = 24;

  /// 100 dp — pill completamente redondeado (botones primarios).
  static const double _button = 100;

  /// 48.61 dp — pill completamente redondeado para chips de tipo.
  static const double _chip = 48.61;

  /// 3 dp — rounding suave de la barra de stat.
  static const double _statBar = 3;

  // ─── Scale ────────────────────────────────────────────────────────────────

  /// 4 dp — rounding sutil para contenedores pequeños.
  static const BorderRadius xs = BorderRadius.all(Radius.circular(_xs));

  /// 8 dp — componentes pequeños.
  static const BorderRadius sm = BorderRadius.all(Radius.circular(_sm));

  /// 12 dp — contenedores de info (peso, altura).
  static const BorderRadius md = BorderRadius.all(Radius.circular(_md));

  /// 16 dp — cards de pokémon.
  static const BorderRadius lg = BorderRadius.all(Radius.circular(_lg));

  /// 24 dp — paneles grandes, bottom sheet.
  static const BorderRadius xl = BorderRadius.all(Radius.circular(_xl));

  // ─── Component aliases ────────────────────────────────────────────────────

  /// Rounding de la card de pokémon (16 dp).
  static const BorderRadius card = lg;

  /// Chips de tipo — forma pill completamente redondeada.
  static const BorderRadius chip = BorderRadius.all(Radius.circular(_chip));

  /// Botones primarios .
  static const BorderRadius button = BorderRadius.all(Radius.circular(_button));

  /// Bottom sheet / modal — solo esquinas superiores (24 dp).
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(_xl),
    topRight: Radius.circular(_xl),
  );

  /// Barra de navegación inferior — solo esquinas superiores (16 dp).
  static const BorderRadius navBar = BorderRadius.only(
    topLeft: Radius.circular(_lg),
    topRight: Radius.circular(_lg),
  );

  /// Stat bar track / fill rounding (3 dp).
  static const BorderRadius statBar = BorderRadius.all(
    Radius.circular(_statBar),
  );

  static const BorderRadius input = BorderRadius.all(Radius.circular(30));
}
