abstract interface class LocaleRepository {
  String getLanguageCode();

  Future<void> setLanguageCode(String languageCode);
}
