import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class IsOnboardingCompletedUseCase extends UseCase<bool, NoParams> {
  const IsOnboardingCompletedUseCase({required this.repository});

  final OnboardingRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final result = await repository.isOnboardingCompleted();
      return Right(result);
    } catch (e) {
      return Left(Failure.cache(message: e.toString()));
    }
  }
}
