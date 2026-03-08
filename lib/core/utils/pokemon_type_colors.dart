import 'package:flutter/material.dart';

abstract final class PokemonTypeColors {
  static const Map<String, Color> _typeColors = {
    'normal': Color(0xFF8BC34A),
    'fire': Color(0xFFFF9800),
    'water': Color(0xFF2196F3),
    'electric': Color(0xFFFDD835),
    'grass': Color(0xFF8BC34A),
    'ice': Color(0xFF3D8BFF),
    'fighting': Color(0xFFE53935),
    'poison': Color(0xFF9C27B0),
    'ground': Color(0xFFFDD835),
    'flying': Color(0xFF00BCD4),
    'psychic': Color(0xFF673AB7),
    'bug': Color(0xFF43A047),
    'rock': Color(0xFF795548),
    'ghost': Color(0xFF8E24AA),
    'dragon': Color(0xFF00ACC1),
    'dark': Color(0xFF705848),
    'steel': Color(0xFF8BC34A),
    'fairy': Color(0xFFE91E63),
  };

  static Color getColor(String type) {
    return _typeColors[type.toLowerCase()] ?? const Color(0xFFA8A878);
  }
}
