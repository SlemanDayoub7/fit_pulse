import 'package:gym_app/core/networking/api_result.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<ApiResult<Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}
