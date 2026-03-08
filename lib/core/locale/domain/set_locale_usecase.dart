import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../errors/failures.dart';
import '../../usecases/usecase.dart';
import 'locale_repository.dart';

final class SetLocaleParams extends Equatable {
  const SetLocaleParams({required this.languageCode});
  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

final class SetLocaleUseCase extends UseCase<Unit, SetLocaleParams> {
  const SetLocaleUseCase({required this.repository});

  final LocaleRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SetLocaleParams params) async {
    try {
      await repository.setLanguageCode(params.languageCode);
      return const Right(unit);
    } catch (e) {
      return Left(Failure.cache(message: e.toString()));
    }
  }
}
