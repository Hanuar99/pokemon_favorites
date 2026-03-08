abstract final class AppDimensions {
  // ─── Íconos ─────────────────────────────────────────────────────────────

  /// 12 dp — ícono pequeño (fila de info en pantalla de detalle).
  static const double iconXs = 12.0;

  /// 16 dp — ícono pequeño (check en el checkbox del filtro).
  static const double iconSm = 16.0;

  /// 18 dp — ícono de borrar / sufijo dentro del campo de búsqueda.
  static const double iconClear = 18.0;

  /// 20 dp — ícono medio (prefijo de búsqueda / ícono del botón de filtro).
  static const double iconMd = 20.0;

  /// 22 dp — ícono dentro del contenedor de fila de ajustes.
  static const double iconLg = 22.0;

  /// 28 dp — ícono grande (papelera de deslizar para borrar / favorito en AppBar de detalle).
  static const double iconXl = 28.0;

  /// 32 dp — tamaño del chevron de flecha atrás en la AppBar de la pantalla de detalle.
  static const double backArrowSize = 32.0;

  /// 52 dp — ícono pokébola dentro del círculo de avatar del perfil.
  static const double profileAvatarIconSize = 52.0;

  // ─── Cards ─────────────────────────────────────────────────────────────

  /// Altura de un [PokemonCard] y su esqueleto equivalente.
  static const double cardHeight = 140.0;

  /// Ancho de la sección de imagen coloreada derecha dentro de un [PokemonCard].
  static const double cardImageAreaWidth = 140.0;

  /// Sprite del Pokémon renderizado dentro de la sección coloreada de la card.
  static const double cardPokemonImage = 94.0;

  /// [SizedBox] invisible que se muestra mientras se carga la imagen hero.
  static const double cardPokemonPlaceholder = 110.0;

  /// Tamaño del ícono de tipo de fondo dentro de la sección coloreada de la card.
  static const double cardTypeIconSize = 94.0;

  // ─── Pantalla de detalle ─────────────────────────────────────────────────

  /// Altura bruta de la banda del encabezado antes de restar [kToolbarHeight].
  static const double detailHeaderRawHeight = 307.0;

  /// Círculo decorativo detrás de la imagen del Pokémon en el encabezado.
  static const double detailCircleSize = 498.0;

  /// Ícono SVG de tipo / pokébola de fondo renderizado en el encabezado.
  static const double detailTypeIconSize = 204.0;

  /// Ancho del sprite del Pokémon en el encabezado de detalle.
  static const double detailPokemonImageWidth = 142.0;

  /// Altura del sprite del Pokémon en el encabezado de detalle.
  static const double detailPokemonImageHeight = 154.0;

  /// Fallback [Icons.catching_pokemon] mostrado cuando el sprite no carga.
  static const double detailFallbackIconSize = 100.0;

  // ─── Barra de estadísticas ───────────────────────────────────────────────

  /// Ancho fijo de la columna de etiqueta del nombre del stat (HP, ATK …).
  static const double statBarLabelWidth = 110.0;

  /// Ancho fijo de la columna del valor numérico.
  static const double statBarValueWidth = 40.0;

  /// Grosor (altura) de cada barra de progreso y su relleno.
  static const double statBarHeight = 6.0;

  // ─── Barra de búsqueda ──────────────────────────────────────────────────

  /// Altura del contenedor de la barra de búsqueda (TextField).
  static const double searchBarHeight = 48.0;

  /// Espacio vertical sobre la barra de búsqueda en la pantalla de lista.
  static const double searchBarTopSpacing = 44.0;

  /// Tamaño del área de toque del botón cuadrado de filtro junto a la barra de búsqueda.
  static const double searchFilterButtonSize = 44.0;

  // ─── Botones ─────────────────────────────────────────────────────────────

  /// Altura del botón primario [AppPrimaryButton].
  static const double buttonHeight = 58.0;

  /// Altura del botón secundario / outlined (ej. Cancelar en el panel de filtros).
  static const double buttonSecondaryHeight = 52.0;

  // ─── Pantalla de perfil ──────────────────────────────────────────────────

  /// Altura expandida del [SliverAppBar] para la banda del encabezado de perfil.
  static const double profileHeaderHeight = 220.0;

  /// Diámetro del contenedor circular del avatar.
  static const double profileAvatarSize = 88.0;

  /// Ancho del borde decorativo alrededor del círculo del avatar.
  static const double profileAvatarBorderWidth = 2.5;

  /// Ancho de la pastilla de arrastre en la parte superior de los bottom sheets.
  static const double dragHandleWidth = 40.0;

  /// Altura de la pastilla de arrastre en la parte superior de los bottom sheets.
  static const double dragHandleHeight = 4.0;

  /// Área de toque cuadrada que envuelve el ícono principal de una fila de ajustes.
  static const double settingIconContainer = 40.0;

  // ─── Panel de filtros ────────────────────────────────────────────────────

  /// Tamaño (ancho = alto) del checkbox personalizado animado.
  static const double filterCheckboxSize = 22.0;

  /// Ancho del borde del contorno del checkbox no seleccionado.
  static const double filterCheckboxBorderWidth = 1.5;

  /// Tamaño del ícono de verificación dentro de un checkbox seleccionado.
  static const double filterCheckIconSize = 16.0;

  // ─── Onboarding ───────────────────────────────────────────────────────────

  /// Diámetro de un punto inactivo del indicador de página.
  static const double pageIndicatorDot = 8.0;

  /// Ancho del punto activo (expandido) del indicador de página.
  static const double pageIndicatorDotActive = 24.0;

  // ─── Esqueleto / Shimmer ─────────────────────────────────────────────────

  /// Ancho del cuadro shimmer del número del Pokémon.
  static const double skeletonNumberWidth = 52.0;

  /// Altura del cuadro shimmer del número del Pokémon.
  static const double skeletonNumberHeight = 13.0;

  /// Ancho del cuadro shimmer del nombre del Pokémon.
  static const double skeletonNameWidth = 140.0;

  /// Altura del cuadro shimmer del nombre del Pokémon.
  static const double skeletonNameHeight = 22.0;

  /// Ancho del cuadro shimmer del chip de tipo.
  static const double skeletonChipWidth = 72.0;

  /// Altura del cuadro shimmer del chip de tipo.
  static const double skeletonChipHeight = 24.0;

  // ─── Deslizar para borrar ──────────────────────────────────────────────

  /// Ícono de papelera en el fondo rojo de deslizar para borrar en Favoritos.
  static const double deleteIconSize = 28.0;

  // ─── Splash ───────────────────────────────────────────────────────────────

  /// Tamaño de la animación de carga de la pokébola en la pantalla de inicio.
  static const double splashPokeballSize = 120.0;
}
