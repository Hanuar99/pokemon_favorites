abstract final class AppSpacing {
  // ─── Escala base ─────────────────────────────────────────────────────────────

  /// 4 dp — espacio extra pequeño.
  static const double xs = 4;

  /// 8 dp — espacio pequeño.
  static const double sm = 8;

  /// 12 dp — espacio medio-pequeño.
  static const double md = 12;

  /// 16 dp — espacio medio (unidad base).
  static const double lg = 16;

  /// 24 dp — espacio grande.
  static const double xl = 24;

  /// 32 dp — espacio extra grande.
  static const double xxl = 32;

  // ─── Específico por componente ───────────────────────────────────────────────

  /// Padding interno de [PokemonCard] y cards similares.
  static const double cardPadding = 12;

  /// Padding horizontal para el contenido de la lista / pantalla.
  static const double screenPadding = 16;

  /// Espacio vertical entre elementos de lista.
  static const double listItemSpacing = 12;

  /// Espacio horizontal entre [PokemonTypeChip]s dentro de una card.
  static const double chipSpacing = 6;

  /// Espacio vertical entre filas de barras de stat en la pantalla de detalle.
  static const double statBarSpacing = 12;
}
