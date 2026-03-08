import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/usecases/usecase.dart';
import '../../di/pokemon_module.dart';

part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
Future<bool> isOnboardingCompleted(Ref ref) async {
  final useCase = ref.watch(isOnboardingCompletedUseCaseProvider);
  final result = await useCase(const NoParams());
  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (isCompleted) => isCompleted,
  );
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> complete() async {
    state = const AsyncLoading();
    final useCase = ref.read(completeOnboardingUseCaseProvider);
    final result = await useCase(const NoParams());
    if (!ref.mounted) return;
    result.fold((failure) => state = AsyncError(failure, StackTrace.current), (
      _,
    ) {
      ref.invalidate(isOnboardingCompletedProvider);
      state = const AsyncData(null);
    });
  }
}
