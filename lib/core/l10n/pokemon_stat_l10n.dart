import 'app_localizations.dart';

String translateStatName(AppLocalizations l10n, String apiStatName) {
  return switch (apiStatName.toLowerCase()) {
    'hp' => l10n.statHp,
    'attack' => l10n.statAttack,
    'defense' => l10n.statDefense,
    'special-attack' => l10n.statSpAttack,
    'special-defense' => l10n.statSpDefense,
    'speed' => l10n.statSpeed,
    _ => apiStatName.toUpperCase(),
  };
}
