import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/entities/pokemon_stat_entity.dart';

part 'pokemon_detail_model.freezed.dart';
part 'pokemon_detail_model.g.dart';

@freezed
abstract class PokemonDetailModel with _$PokemonDetailModel {
  const factory PokemonDetailModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    @JsonKey(name: 'base_experience') @Default(0) int baseExperience,
    required PokemonSpritesModel sprites,
    required List<PokemonTypeSlotModel> types,
    required List<PokemonStatModel> stats,
    required List<PokemonAbilitySlotModel> abilities,
  }) = _PokemonDetailModel;

  const PokemonDetailModel._();

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);

  String get cardImageUrl => sprites.frontDefault;
  String get showdownImageUrl => sprites.other.showdown.frontDefault;

  double get heightInMeters => height / 10;
  double get weightInKg => weight / 10;

  PokemonDetailEntity toDetailEntity() {
    return PokemonDetailEntity(
      id: id,
      name: name,
      imageUrl: showdownImageUrl,
      types: types.map((t) => t.type.name).toList(),
      stats: stats
          .map(
            (s) =>
                PokemonStatEntity(statName: s.stat.name, baseStat: s.baseStat),
          )
          .toList(),
      heightInMeters: heightInMeters,
      weightInKg: weightInKg,
      baseExperience: baseExperience,
      abilities: abilities
          .where((a) => !a.isHidden)
          .map((a) => a.ability.name)
          .toList(),
    );
  }
}

@freezed
abstract class PokemonSpritesModel with _$PokemonSpritesModel {
  const factory PokemonSpritesModel({
    @JsonKey(name: 'front_default') required String frontDefault,
    required PokemonOtherModel other,
  }) = _PokemonSpritesModel;

  factory PokemonSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesModelFromJson(json);
}

@freezed
abstract class PokemonOtherModel with _$PokemonOtherModel {
  const factory PokemonOtherModel({
    @JsonKey(name: 'showdown') required ShowdownModel showdown,
  }) = _PokemonOtherModel;

  factory PokemonOtherModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonOtherModelFromJson(json);
}

@freezed
abstract class ShowdownModel with _$ShowdownModel {
  const factory ShowdownModel({
    @JsonKey(name: 'front_default') required String frontDefault,
  }) = _ShowdownModel;

  factory ShowdownModel.fromJson(Map<String, dynamic> json) =>
      _$ShowdownModelFromJson(json);
}

@freezed
abstract class PokemonTypeSlotModel with _$PokemonTypeSlotModel {
  const factory PokemonTypeSlotModel({
    required int slot,
    required PokemonTypeModel type,
  }) = _PokemonTypeSlotModel;

  factory PokemonTypeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeSlotModelFromJson(json);
}

@freezed
abstract class PokemonTypeModel with _$PokemonTypeModel {
  const factory PokemonTypeModel({required String name, required String url}) =
      _PokemonTypeModel;

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeModelFromJson(json);
}

@freezed
abstract class PokemonStatModel with _$PokemonStatModel {
  const factory PokemonStatModel({
    @JsonKey(name: 'base_stat') required int baseStat,
    required int effort,
    required PokemonStatInfoModel stat,
  }) = _PokemonStatModel;

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);
}

@freezed
abstract class PokemonStatInfoModel with _$PokemonStatInfoModel {
  const factory PokemonStatInfoModel({
    required String name,
    required String url,
  }) = _PokemonStatInfoModel;

  factory PokemonStatInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatInfoModelFromJson(json);
}

@freezed
abstract class PokemonAbilitySlotModel with _$PokemonAbilitySlotModel {
  const factory PokemonAbilitySlotModel({
    required PokemonAbilityModel ability,
    @JsonKey(name: 'is_hidden') required bool isHidden,
    required int slot,
  }) = _PokemonAbilitySlotModel;

  factory PokemonAbilitySlotModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilitySlotModelFromJson(json);
}

@freezed
abstract class PokemonAbilityModel with _$PokemonAbilityModel {
  const factory PokemonAbilityModel({
    required String name,
    required String url,
  }) = _PokemonAbilityModel;

  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityModelFromJson(json);
}
