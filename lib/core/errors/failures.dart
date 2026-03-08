import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    required int statusCode,
  }) = ServerFailure;

  const factory Failure.network({required String message}) = NetworkFailure;

  const factory Failure.cache({required String message}) = CacheFailure;

  const factory Failure.unknown({required String message}) = UnknownFailure;
}
