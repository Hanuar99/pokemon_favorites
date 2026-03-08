abstract final class ApiConstants {
  /// PokeAPI v2 base URL.
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  /// Endpoint to list Pokémon (paginated).
  static const String pokemonEndpoint = '/pokemon';

  /// Endpoint details.
  static String pokemonDetailEndpoint(String nameOrId) => '/pokemon/$nameOrId';
}
