// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchHint => 'Search Pokémon…';

  @override
  String get retry => 'Retry';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get errorTitle => 'Something went wrong...';

  @override
  String get errorDescription =>
      'We couldn\'t load the information right now. Check your connection or try again later.';

  @override
  String get noFavoritesTitle => 'You haven\'t marked any Pokémon as favorite';

  @override
  String get comingSoonTitle => 'Coming soon!';

  @override
  String get comingSoonDescription =>
      'We are working to bring you this section. Come back later to discover all the news.';

  @override
  String get onboardingTitle1 => 'All Pokémon in one place';

  @override
  String get onboardingDesc1 =>
      'Access a wide list of Pokémon from all generations created by Nintendo';

  @override
  String get onboardingTitle2 => 'Keep your Pokédex updated';

  @override
  String get onboardingDesc2 =>
      'Sign up and save your profile, favorite Pokémon, settings and more in the app';

  @override
  String get continueButton => 'Continue';

  @override
  String get letsStartButton => 'Let\'s start';

  @override
  String get clearFilter => 'Clear filter';

  @override
  String resultsFound(Object count) {
    return '$count results found';
  }

  @override
  String get filterTitle => 'Filter by your preferences';

  @override
  String get filterType => 'Type';

  @override
  String get applyFilter => 'Apply';

  @override
  String get cancelFilter => 'Cancel';

  @override
  String get baseExperience => 'Base Exp.';

  @override
  String get ability => 'Ability';

  @override
  String get noFavoritesSubtitle =>
      'Tap the heart icon on your favorite\nPokémon and they will appear here.';

  @override
  String get baseStats => 'Base Stats';

  @override
  String get noResults => 'No results';

  @override
  String get noResultsSubtitle =>
      'We couldn\'t find Pokémon matching your search.';

  @override
  String get statHp => 'HP';

  @override
  String get statAttack => 'ATK';

  @override
  String get statDefense => 'DEF';

  @override
  String get statSpAttack => 'SATK';

  @override
  String get statSpDefense => 'SDEF';

  @override
  String get statSpeed => 'SPD';

  @override
  String pokemonNumber(Object number) {
    return 'N°$number';
  }

  @override
  String semanticFavoriteButton(Object name) {
    return 'Toggle favorite for $name';
  }

  @override
  String get tabPokedex => 'Pokedex';

  @override
  String get tabRegions => 'Regions';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get tabProfile => 'Profile';

  @override
  String get typeWater => 'Water';

  @override
  String get typeFire => 'Fire';

  @override
  String get typeGrass => 'Grass';

  @override
  String get typeElectric => 'Electric';

  @override
  String get typeIce => 'Ice';

  @override
  String get typeFighting => 'Fighting';

  @override
  String get typePoison => 'Poison';

  @override
  String get typeGround => 'Ground';

  @override
  String get typeFlying => 'Flying';

  @override
  String get typePsychic => 'Psychic';

  @override
  String get typeBug => 'Bug';

  @override
  String get typeRock => 'Rock';

  @override
  String get typeGhost => 'Ghost';

  @override
  String get typeDragon => 'Dragon';

  @override
  String get typeDark => 'Dark';

  @override
  String get typeSteel => 'Steel';

  @override
  String get typeFairy => 'Fairy';

  @override
  String get typeNormal => 'Normal';

  @override
  String get profileTrainerName => 'Ash Ketchum';

  @override
  String get profileTrainerSubtitle => 'Pokémon Trainer';

  @override
  String get profileSettingsTitle => 'Settings';

  @override
  String get profileLanguageTitle => 'Language';
}
