import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// Extensión de conveniencia sobre [BuildContext] para acceder
/// a las traducciones de forma concisa: `context.l10n.appTitle`.
extension L10nExtension on BuildContext {
  /// Retorna la instancia de [AppLocalizations] del contexto actual.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
