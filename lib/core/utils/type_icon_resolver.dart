import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class TypeIconResolver {
  const TypeIconResolver._();

  // ─── Static map: type name → SvgGenImage ────────────────────────────────
  static final Map<String, SvgGenImage> _typeIcons = {
    'bug': Assets.icons.elements.bug,
    'dark': Assets.icons.elements.dark,
    'dragon': Assets.icons.elements.dragon,
    'electric': Assets.icons.elements.electric,
    'fairy': Assets.icons.elements.fairy,
    'fighting': Assets.icons.elements.fighting,
    'fire': Assets.icons.elements.fire,
    'flying': Assets.icons.elements.flying,
    'ghost': Assets.icons.elements.ghost,
    'grass': Assets.icons.elements.grass,
    'ground': Assets.icons.elements.ground,
    'ice': Assets.icons.elements.ice,
    'normal': Assets.icons.elements.normal,
    'poison': Assets.icons.elements.poison,
    'psychic': Assets.icons.elements.psychic,
    'rock': Assets.icons.elements.rock,
    'steel': Assets.icons.elements.steel,
    'water': Assets.icons.elements.water,
  };

  static Widget icon(
    String typeName, {
    double size = 18,
    ColorFilter? colorFilter,
    WidgetBuilder? placeholderBuilder,
  }) {
    final svgImage = _typeIcons[typeName.toLowerCase()];

    if (svgImage == null) {
      return Icon(Icons.catching_pokemon, size: size, color: Colors.white);
    }

    return svgImage.svg(
      width: size,
      height: size,
      colorFilter: colorFilter,
      placeholderBuilder:
          placeholderBuilder ??
          (_) => Icon(Icons.catching_pokemon, size: size, color: Colors.white),
    );
  }
}
