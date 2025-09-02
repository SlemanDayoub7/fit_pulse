import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc_status.freezed.dart';

@freezed
class BlocStatus<T> with _$BlocStatus<T> {
  const factory BlocStatus.initial() = Initial;
  const factory BlocStatus.loading() = Loading;
  const factory BlocStatus.success(T data) = Success<T>;
  const factory BlocStatus.error(String message) = Error;
}
