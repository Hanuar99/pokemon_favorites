// Módulo de DI de la feature Pokémon.
//
// Declara el grafo completo de dependencias en el orden de la cadena:
//
//   [dioProvider]
//       └── [pokemonRemoteDatasourceProvider]
//   [sharedPreferencesProvider]
//       └── [pokemonLocalDatasourceProvider]
//   [pokemonRemoteDatasourceProvider] + [pokemonLocalDatasourceProvider]
//       └── [pokemonRepositoryProvider]
//   [pokemonRepositoryProvider]
//       ├── [getPokemonListUseCaseProvider]
//       ├── [getPokemonDetailUseCaseProvider]
//       ├── [toggleFavoriteUseCaseProvider]
//       └── [getFavoritesUseCaseProvider]
//   [sharedPreferencesProvider]
//       ├── [isOnboardingCompletedUseCaseProvider]
//       └── [completeOnboardingUseCaseProvider]
//
// Todos los providers son [keepAlive: true] — se instancian una sola vez
// y viven durante toda la sesión de la app.
//
// La capa [domain] nunca importa este archivo: permanece Dart puro.
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/providers/shared_preferences_provider.dart';
import '../data/datasources/pokemon_local_datasource.dart';
import '../data/datasources/pokemon_remote_datasource.dart';
import '../data/repositories/onboarding_repository_impl.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../domain/usecases/complete_onboarding_usecase.dart';
import '../domain/usecases/get_favorites_usecase.dart';
import '../domain/usecases/get_pokemon_detail_usecase.dart';
import '../domain/usecases/get_pokemon_list_usecase.dart';
import '../domain/usecases/is_onboarding_completed_usecase.dart';
import '../domain/usecases/toggle_favorite_usecase.dart';

part 'pokemon_module.g.dart';

// ─── Datasources ───────────────────────────────────────────────────────────────

/// Singleton del datasource remoto.
///
/// Depende de [dioProvider] (HTTP client configurado con base URL y timeouts).
@Riverpod(keepAlive: true)
PokemonRemoteDatasource pokemonRemoteDatasource(Ref ref) {
  return PokemonRemoteDatasourceImpl(dio: ref.watch(dioProvider));
}

/// Singleton del datasource local.
///
/// Reutiliza la instancia de [SharedPreferences] inyectada en [ProviderScope].
/// El [init] carga el cache en memoria una sola vez.
@Riverpod(keepAlive: true)
Future<PokemonLocalDatasource> pokemonLocalDatasource(Ref ref) async {
  final prefs = ref.watch(sharedPreferencesProvider);
  final datasource = PokemonLocalDatasourceImpl(sharedPreferences: prefs);
  await datasource.init();
  return datasource;
}

// ─── Repository ────────────────────────────────────────────────────────────────

/// Singleton del repositorio de Pokémon.
///
/// Expone la abstracción [PokemonRepository], nunca la implementación concreta,
/// respetando el principio de Inversión de Dependencias (DIP).
@Riverpod(keepAlive: true)
Future<PokemonRepository> pokemonRepository(Ref ref) async {
  final remote = ref.watch(pokemonRemoteDatasourceProvider);
  final local = await ref.watch(pokemonLocalDatasourceProvider.future);
  return PokemonRepositoryImpl(
    remoteDatasource: remote,
    localDatasource: local,
  );
}

// ─── Use Cases ─────────────────────────────────────────────────────────────────

/// Provee [GetPokemonListUseCase] listo para paginar la lista de Pokémon.
@Riverpod(keepAlive: true)
Future<GetPokemonListUseCase> getPokemonListUseCase(Ref ref) async {
  final repository = await ref.watch(pokemonRepositoryProvider.future);
  return GetPokemonListUseCase(repository: repository);
}

/// Provee [GetPokemonDetailUseCase] para obtener el detalle de un Pokémon.
@Riverpod(keepAlive: true)
Future<GetPokemonDetailUseCase> getPokemonDetailUseCase(Ref ref) async {
  final repository = await ref.watch(pokemonRepositoryProvider.future);
  return GetPokemonDetailUseCase(repository: repository);
}

/// Provee [ToggleFavoriteUseCase] para agregar o quitar favoritos.
@Riverpod(keepAlive: true)
Future<ToggleFavoriteUseCase> toggleFavoriteUseCase(Ref ref) async {
  final repository = await ref.watch(pokemonRepositoryProvider.future);
  return ToggleFavoriteUseCase(repository: repository);
}

/// Provee [GetFavoritesUseCase] para leer la lista de favoritos en memoria.
@Riverpod(keepAlive: true)
Future<GetFavoritesUseCase> getFavoritesUseCase(Ref ref) async {
  final repository = await ref.watch(pokemonRepositoryProvider.future);
  return GetFavoritesUseCase(repository: repository);
}

// ─── Onboarding Use Cases ──────────────────────────────────────────────────────

/// Provee [IsOnboardingCompletedUseCase].
///
/// Usa [SharedPreferences] directamente — el onboarding no comparte
/// repositorio con la feature de Pokémon.
@Riverpod(keepAlive: true)
IsOnboardingCompletedUseCase isOnboardingCompletedUseCase(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return IsOnboardingCompletedUseCase(
    repository: OnboardingRepositoryImpl(prefs),
  );
}

/// Provee [CompleteOnboardingUseCase] para marcar el onboarding como completado.
@Riverpod(keepAlive: true)
CompleteOnboardingUseCase completeOnboardingUseCase(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CompleteOnboardingUseCase(repository: OnboardingRepositoryImpl(prefs));
}
