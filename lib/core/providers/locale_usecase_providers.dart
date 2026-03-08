import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../locale/data/locale_repository_impl.dart';
import '../locale/domain/get_locale_usecase.dart';
import '../locale/domain/set_locale_usecase.dart';
import 'shared_preferences_provider.dart';

part 'locale_usecase_providers.g.dart';

@Riverpod(keepAlive: true)
GetLocaleUseCase getLocaleUseCase(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final repository = LocaleRepositoryImpl(prefs);
  return GetLocaleUseCase(repository: repository);
}

@Riverpod(keepAlive: true)
SetLocaleUseCase setLocaleUseCase(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final repository = LocaleRepositoryImpl(prefs);
  return SetLocaleUseCase(repository: repository);
}
