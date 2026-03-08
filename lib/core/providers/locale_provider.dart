import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../locale/domain/set_locale_usecase.dart';
import '../usecases/usecase.dart';
import 'locale_usecase_providers.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final getUseCase = ref.watch(getLocaleUseCaseProvider);
    final result = getUseCase(const NoParams());
    return result.fold((_) => const Locale('es'), (code) => Locale(code));
  }

  Future<void> setLocale(Locale locale) async {
    final setUseCase = ref.read(setLocaleUseCaseProvider);
    final result = await setUseCase(
      SetLocaleParams(languageCode: locale.languageCode),
    );
    result.fold((_) => null, (_) => state = locale);
  }
}
