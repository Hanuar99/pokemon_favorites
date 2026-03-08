import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase extends UseCase<Unit, NoParams> {
  const CompleteOnboardingUseCase({required this.repository});

  final OnboardingRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    try {
      await repository.completeOnboarding();
      return const Right(unit);
    } catch (e) {
      return Left(Failure.cache(message: e.toString()));
    }
  }
}
