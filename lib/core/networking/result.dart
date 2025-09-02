import 'package:gym_app/core/networking/api_error_model.dart';

class Result<T> {
  final T? data;
  final ApiErrorModel? apiErrorModel;

  Result.success(this.data) : apiErrorModel = null;
  Result.failure(this.apiErrorModel) : data = null;

  void when({
    required Function(T data) success,
    required Function(Result error) failure,
  }) {
    if (data != null) {
      success(data!);
    } else {
      failure(this);
    }
  }
}
