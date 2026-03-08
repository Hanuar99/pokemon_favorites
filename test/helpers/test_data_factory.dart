import 'package:pokemon_favorites/core/errors/failures.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokemon_favorites/features/pokemon/domain/entities/pokemon_stat_entity.dart';
import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_detail_model.dart';
import 'package:pokemon_favorites/features/pokemon/data/models/pokemon_model.dart';

// ─── Entities ─────────────────────────────────────────────────────────────────

/// Pokémon de prueba: Bulbasaur.
const tPokemonEntity = PokemonEntity(
  id: 1,
  name: 'bulbasaur',
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  types: ['grass', 'poison'],
);

/// Segundo Pokémon de prueba: Ivysaur.
const tPokemonEntityIvysaur = PokemonEntity(
  id: 2,
  name: 'ivysaur',
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
  types: ['grass', 'poison'],
);

/// Tercer Pokémon de prueba: Venusaur.
const tPokemonEntityVenusaur = PokemonEntity(
  id: 3,
  name: 'venusaur',
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
  types: ['grass', 'poison'],
);

/// Lista completa de prueba con 3 Pokémon.
const tPokemonList = [
  tPokemonEntity,
  tPokemonEntityIvysaur,
  tPokemonEntityVenusaur,
];

/// Detalle completo de Bulbasaur (dominio).
const tPokemonDetailEntity = PokemonDetailEntity(
  id: 1,
  name: 'bulbasaur',
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  types: ['grass', 'poison'],
  stats: [
    PokemonStatEntity(statName: 'hp', baseStat: 45),
    PokemonStatEntity(statName: 'attack', baseStat: 49),
    PokemonStatEntity(statName: 'defense', baseStat: 49),
    PokemonStatEntity(statName: 'special-attack', baseStat: 65),
    PokemonStatEntity(statName: 'special-defense', baseStat: 65),
    PokemonStatEntity(statName: 'speed', baseStat: 45),
  ],
  heightInMeters: 0.7,
  weightInKg: 6.9,
  baseExperience: 64,
  abilities: ['overgrow'],
);

// ─── Failures ─────────────────────────────────────────────────────────────────

/// Failures reutilizables para todos los tests.
abstract final class TestFailures {
  static const Failure server = Failure.server(
    message: 'Internal Server Error',
    statusCode: 500,
  );

  static const Failure network = Failure.network(
    message: 'No internet connection',
  );

  static const Failure cache = Failure.cache(
    message: 'Failed to persist favorites.',
  );

  static const Failure notFound = Failure.server(
    message: 'Not Found',
    statusCode: 404,
  );

  static const Failure unknown = Failure.unknown(message: 'Unexpected error');
}

// ─── Models ───────────────────────────────────────────────────────────────────

/// Lista de [PokemonModel] equivalente a [tPokemonList] para stubbear
/// el datasource remoto en los tests del repository.
const tPokemonModelList = [
  PokemonModel(
    id: 1,
    name: 'bulbasaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    types: ['grass', 'poison'],
  ),
  PokemonModel(
    id: 2,
    name: 'ivysaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
    types: ['grass', 'poison'],
  ),
  PokemonModel(
    id: 3,
    name: 'venusaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
    types: ['grass', 'poison'],
  ),
];

/// Modelo de detalle de Bulbasaur para tests del repositorio/datasource.
PokemonDetailModel tPokemonDetailModel() => const PokemonDetailModel(
  id: 1,
  name: 'bulbasaur',
  height: 7,
  weight: 69,
  baseExperience: 64,
  sprites: PokemonSpritesModel(
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    other: PokemonOtherModel(
      showdown: ShowdownModel(
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.svg',
      ),
    ),
  ),
  types: [
    PokemonTypeSlotModel(
      slot: 1,
      type: PokemonTypeModel(
        name: 'grass',
        url: 'https://pokeapi.co/api/v2/type/12/',
      ),
    ),
    PokemonTypeSlotModel(
      slot: 2,
      type: PokemonTypeModel(
        name: 'poison',
        url: 'https://pokeapi.co/api/v2/type/4/',
      ),
    ),
  ],
  stats: [
    PokemonStatModel(
      baseStat: 45,
      effort: 0,
      stat: PokemonStatInfoModel(
        name: 'hp',
        url: 'https://pokeapi.co/api/v2/stat/1/',
      ),
    ),
    PokemonStatModel(
      baseStat: 49,
      effort: 0,
      stat: PokemonStatInfoModel(
        name: 'attack',
        url: 'https://pokeapi.co/api/v2/stat/2/',
      ),
    ),
    PokemonStatModel(
      baseStat: 49,
      effort: 0,
      stat: PokemonStatInfoModel(
        name: 'defense',
        url: 'https://pokeapi.co/api/v2/stat/3/',
      ),
    ),
    PokemonStatModel(
      baseStat: 65,
      effort: 1,
      stat: PokemonStatInfoModel(
        name: 'special-attack',
        url: 'https://pokeapi.co/api/v2/stat/4/',
      ),
    ),
    PokemonStatModel(
      baseStat: 65,
      effort: 0,
      stat: PokemonStatInfoModel(
        name: 'special-defense',
        url: 'https://pokeapi.co/api/v2/stat/5/',
      ),
    ),
    PokemonStatModel(
      baseStat: 45,
      effort: 0,
      stat: PokemonStatInfoModel(
        name: 'speed',
        url: 'https://pokeapi.co/api/v2/stat/6/',
      ),
    ),
  ],
  abilities: [
    PokemonAbilitySlotModel(
      ability: PokemonAbilityModel(
        name: 'overgrow',
        url: 'https://pokeapi.co/api/v2/ability/65/',
      ),
      isHidden: false,
      slot: 1,
    ),
    PokemonAbilitySlotModel(
      ability: PokemonAbilityModel(
        name: 'chlorophyll',
        url: 'https://pokeapi.co/api/v2/ability/34/',
      ),
      isHidden: true,
      slot: 3,
    ),
  ],
);

/// Modelo minimal de Ivysaur para tests de la lista.
PokemonDetailModel tPokemonDetailModelIvysaur() => const PokemonDetailModel(
  id: 2,
  name: 'ivysaur',
  height: 10,
  weight: 130,
  baseExperience: 142,
  sprites: PokemonSpritesModel(
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
    other: PokemonOtherModel(
      showdown: ShowdownModel(
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/2.svg',
      ),
    ),
  ),
  types: [
    PokemonTypeSlotModel(
      slot: 1,
      type: PokemonTypeModel(
        name: 'grass',
        url: 'https://pokeapi.co/api/v2/type/12/',
      ),
    ),
    PokemonTypeSlotModel(
      slot: 2,
      type: PokemonTypeModel(
        name: 'poison',
        url: 'https://pokeapi.co/api/v2/type/4/',
      ),
    ),
  ],
  stats: [],
  abilities: [
    PokemonAbilitySlotModel(
      ability: PokemonAbilityModel(
        name: 'overgrow',
        url: 'https://pokeapi.co/api/v2/ability/65/',
      ),
      isHidden: false,
      slot: 1,
    ),
  ],
);

/// Modelo minimal de Venusaur para tests de la lista.
PokemonDetailModel tPokemonDetailModelVenusaur() => const PokemonDetailModel(
  id: 3,
  name: 'venusaur',
  height: 20,
  weight: 1000,
  baseExperience: 263,
  sprites: PokemonSpritesModel(
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
    other: PokemonOtherModel(
      showdown: ShowdownModel(
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/3.svg',
      ),
    ),
  ),
  types: [
    PokemonTypeSlotModel(
      slot: 1,
      type: PokemonTypeModel(
        name: 'grass',
        url: 'https://pokeapi.co/api/v2/type/12/',
      ),
    ),
    PokemonTypeSlotModel(
      slot: 2,
      type: PokemonTypeModel(
        name: 'poison',
        url: 'https://pokeapi.co/api/v2/type/4/',
      ),
    ),
  ],
  stats: [],
  abilities: [
    PokemonAbilitySlotModel(
      ability: PokemonAbilityModel(
        name: 'overgrow',
        url: 'https://pokeapi.co/api/v2/ability/65/',
      ),
      isHidden: false,
      slot: 1,
    ),
  ],
);
