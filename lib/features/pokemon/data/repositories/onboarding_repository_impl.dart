import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  /// Crea un [OnboardingRepositoryImpl].
  const OnboardingRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _kKey = 'onboarding_completed';

  @override
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_kKey) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_kKey, true);
  }
}
