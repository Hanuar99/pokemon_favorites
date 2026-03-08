import 'package:shared_preferences/shared_preferences.dart';

import '../domain/locale_repository.dart';

final class LocaleRepositoryImpl implements LocaleRepository {
  const LocaleRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _kKey = 'locale_language_code';
  static const _kDefault = 'es';

  @override
  String getLanguageCode() => _prefs.getString(_kKey) ?? _kDefault;

  @override
  Future<void> setLanguageCode(String languageCode) async {
    await _prefs.setString(_kKey, languageCode);
  }
}
