import 'app_localizations.dart';

String translatePokemonType(AppLocalizations l10n, String apiType) {
  return switch (apiType.toLowerCase()) {
    'water' => l10n.typeWater,
    'fire' => l10n.typeFire,
    'grass' => l10n.typeGrass,
    'electric' => l10n.typeElectric,
    'ice' => l10n.typeIce,
    'fighting' => l10n.typeFighting,
    'poison' => l10n.typePoison,
    'ground' => l10n.typeGround,
    'flying' => l10n.typeFlying,
    'psychic' => l10n.typePsychic,
    'bug' => l10n.typeBug,
    'rock' => l10n.typeRock,
    'ghost' => l10n.typeGhost,
    'dragon' => l10n.typeDragon,
    'dark' => l10n.typeDark,
    'steel' => l10n.typeSteel,
    'fairy' => l10n.typeFairy,
    'normal' => l10n.typeNormal,
    _ => apiType,
  };
}
