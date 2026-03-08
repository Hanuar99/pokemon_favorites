// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/elements
  $AssetsIconsElementsGen get elements => const $AssetsIconsElementsGen();

  /// File path: assets/icons/favorite_active.svg
  SvgGenImage get favoriteActive =>
      const SvgGenImage('assets/icons/favorite_active.svg');

  /// File path: assets/icons/favorite_inactive.svg
  SvgGenImage get favoriteInactive =>
      const SvgGenImage('assets/icons/favorite_inactive.svg');

  /// List of all assets
  List<SvgGenImage> get values => [favoriteActive, favoriteInactive];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/onboarding
  $AssetsImagesOnboardingGen get onboarding =>
      const $AssetsImagesOnboardingGen();
}

class $AssetsPlaceholdersGen {
  const $AssetsPlaceholdersGen();

  /// File path: assets/placeholders/jigglypuff_coming_soon.png
  AssetGenImage get jigglypuffComingSoon =>
      const AssetGenImage('assets/placeholders/jigglypuff_coming_soon.png');

  /// File path: assets/placeholders/loader.png
  AssetGenImage get loader =>
      const AssetGenImage('assets/placeholders/loader.png');

  /// File path: assets/placeholders/magikarp_error.png
  AssetGenImage get magikarpError =>
      const AssetGenImage('assets/placeholders/magikarp_error.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    jigglypuffComingSoon,
    loader,
    magikarpError,
  ];
}

class $AssetsIconsElementsGen {
  const $AssetsIconsElementsGen();

  /// File path: assets/icons/elements/bug.svg
  SvgGenImage get bug => const SvgGenImage('assets/icons/elements/bug.svg');

  /// File path: assets/icons/elements/dark.svg
  SvgGenImage get dark => const SvgGenImage('assets/icons/elements/dark.svg');

  /// File path: assets/icons/elements/dragon.svg
  SvgGenImage get dragon =>
      const SvgGenImage('assets/icons/elements/dragon.svg');

  /// File path: assets/icons/elements/electric.svg
  SvgGenImage get electric =>
      const SvgGenImage('assets/icons/elements/electric.svg');

  /// File path: assets/icons/elements/fairy.svg
  SvgGenImage get fairy => const SvgGenImage('assets/icons/elements/fairy.svg');

  /// File path: assets/icons/elements/fighting.svg
  SvgGenImage get fighting =>
      const SvgGenImage('assets/icons/elements/fighting.svg');

  /// File path: assets/icons/elements/fire.svg
  SvgGenImage get fire => const SvgGenImage('assets/icons/elements/fire.svg');

  /// File path: assets/icons/elements/flying.svg
  SvgGenImage get flying =>
      const SvgGenImage('assets/icons/elements/flying.svg');

  /// File path: assets/icons/elements/ghost.svg
  SvgGenImage get ghost => const SvgGenImage('assets/icons/elements/ghost.svg');

  /// File path: assets/icons/elements/grass.svg
  SvgGenImage get grass => const SvgGenImage('assets/icons/elements/grass.svg');

  /// File path: assets/icons/elements/ground.svg
  SvgGenImage get ground =>
      const SvgGenImage('assets/icons/elements/ground.svg');

  /// File path: assets/icons/elements/ice.svg
  SvgGenImage get ice => const SvgGenImage('assets/icons/elements/ice.svg');

  /// File path: assets/icons/elements/normal.svg
  SvgGenImage get normal =>
      const SvgGenImage('assets/icons/elements/normal.svg');

  /// File path: assets/icons/elements/poison.svg
  SvgGenImage get poison =>
      const SvgGenImage('assets/icons/elements/poison.svg');

  /// File path: assets/icons/elements/psychic.svg
  SvgGenImage get psychic =>
      const SvgGenImage('assets/icons/elements/psychic.svg');

  /// File path: assets/icons/elements/rock.svg
  SvgGenImage get rock => const SvgGenImage('assets/icons/elements/rock.svg');

  /// File path: assets/icons/elements/steel.svg
  SvgGenImage get steel => const SvgGenImage('assets/icons/elements/steel.svg');

  /// File path: assets/icons/elements/water.svg
  SvgGenImage get water => const SvgGenImage('assets/icons/elements/water.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    bug,
    dark,
    dragon,
    electric,
    fairy,
    fighting,
    fire,
    flying,
    ghost,
    grass,
    ground,
    ice,
    normal,
    poison,
    psychic,
    rock,
    steel,
    water,
  ];
}

class $AssetsImagesOnboardingGen {
  const $AssetsImagesOnboardingGen();

  /// File path: assets/images/onboarding/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding/onboarding1.png');

  /// File path: assets/images/onboarding/onboarding2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding/onboarding2.png');

  /// List of all assets
  List<AssetGenImage> get values => [onboarding1, onboarding2];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPlaceholdersGen placeholders = $AssetsPlaceholdersGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
