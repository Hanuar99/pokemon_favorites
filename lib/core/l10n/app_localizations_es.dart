// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get searchHint => 'Procurar Pókemon...';

  @override
  String get retry => 'Reintentar';

  @override
  String get height => 'Altura';

  @override
  String get weight => 'Peso';

  @override
  String get errorTitle => 'Algo salió mal...';

  @override
  String get errorDescription =>
      'No pudimos cargar la información en este momento. Verifica tu conexión o intenta nuevamente más tarde.';

  @override
  String get noFavoritesTitle => 'No has marcado ningún Pokémon como favorito';

  @override
  String get comingSoonTitle => '¡Muy pronto disponible!';

  @override
  String get comingSoonDescription =>
      'Estamos trabajando para traerte esta sección. Vuelve más adelante para descubrir todas las novedades.';

  @override
  String get onboardingTitle1 => 'Todos los Pokémon en un solo lugar';

  @override
  String get onboardingDesc1 =>
      'Accede a una amplia lista de Pokémon de todas las generaciones creadas por Nintendo';

  @override
  String get onboardingTitle2 => 'Mantén tu Pokédex actualizada';

  @override
  String get onboardingDesc2 =>
      'Regístrate y guarda tu perfil, Pokémon favoritos, configuraciones y mucho más en la aplicación';

  @override
  String get continueButton => 'Continuar';

  @override
  String get letsStartButton => 'Empecemos';

  @override
  String get clearFilter => 'Borrar filtro';

  @override
  String resultsFound(Object count) {
    return 'Se han encontrado $count resultados';
  }

  @override
  String get filterTitle => 'Filtra por tus preferencias';

  @override
  String get filterType => 'Tipo';

  @override
  String get applyFilter => 'Aplicar';

  @override
  String get cancelFilter => 'Cancelar';

  @override
  String get baseExperience => 'Exp. Base';

  @override
  String get ability => 'Habilidad';

  @override
  String get noFavoritesSubtitle =>
      'Haz clic en el ícono de corazón de tus\nPokémon favoritos y aparecerán aquí.';

  @override
  String get baseStats => 'Estadísticas Base';

  @override
  String get noResults => 'Sin resultados';

  @override
  String get noResultsSubtitle =>
      'No encontramos Pokémon que coincidan con tu búsqueda.';

  @override
  String get statHp => 'HP';

  @override
  String get statAttack => 'ATAQUE';

  @override
  String get statDefense => 'DEFENSA';

  @override
  String get statSpAttack => 'AT. ESP.';

  @override
  String get statSpDefense => 'DEF. ESP.';

  @override
  String get statSpeed => 'VELOC.';

  @override
  String pokemonNumber(Object number) {
    return 'N°$number';
  }

  @override
  String semanticFavoriteButton(Object name) {
    return 'Alternar favorito para $name';
  }

  @override
  String get tabPokedex => 'Pokédex';

  @override
  String get tabRegions => 'Regiones';

  @override
  String get tabFavorites => 'favoritos';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get typeWater => 'Agua';

  @override
  String get typeFire => 'Fuego';

  @override
  String get typeGrass => 'Planta';

  @override
  String get typeElectric => 'Eléctrico';

  @override
  String get typeIce => 'Hielo';

  @override
  String get typeFighting => 'Lucha';

  @override
  String get typePoison => 'Veneno';

  @override
  String get typeGround => 'Tierra';

  @override
  String get typeFlying => 'Volador';

  @override
  String get typePsychic => 'Psíquico';

  @override
  String get typeBug => 'Bicho';

  @override
  String get typeRock => 'Roca';

  @override
  String get typeGhost => 'Fantasma';

  @override
  String get typeDragon => 'Dragón';

  @override
  String get typeDark => 'Siniestro';

  @override
  String get typeSteel => 'Acero';

  @override
  String get typeFairy => 'Hada';

  @override
  String get typeNormal => 'Normal';

  @override
  String get profileTrainerName => 'Ash Ketchum';

  @override
  String get profileTrainerSubtitle => 'Entrenador Pokémon';

  @override
  String get profileSettingsTitle => 'Configuración';

  @override
  String get profileLanguageTitle => 'Idioma';
}
