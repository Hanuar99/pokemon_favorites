import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';
import '../../usecases/usecase.dart';
import 'locale_repository.dart';

final class GetLocaleUseCase extends SyncUseCase<String, NoParams> {
  const GetLocaleUseCase({required this.repository});

  final LocaleRepository repository;

  @override
  Either<Failure, String> call(NoParams params) {
    try {
      return Right(repository.getLanguageCode());
    } catch (e) {
      return Left(Failure.cache(message: e.toString()));
    }
  }
}
