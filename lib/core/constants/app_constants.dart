abstract final class AppConstants {
  /// Name of the application.
  static const String appName = 'Pokemon Favorites';

  /// Default page size for paginated Pokémon lists.
  static const int defaultPageSize = 20;

  /// Key used to persist favorite Pokémon.
  static const String favoritesStorageKey = 'pokemon_favorites_list';

  /// Maximum number of Pokémon a user can mark as favorites.
  static const int maxFavorites = 50;
}
