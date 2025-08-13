import 'package:nudge/core/dio_provider/api_response.dart';
import 'package:nudge/core/dio_provider/dio_api_client.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:dartz/dartz.dart';

class {{name.pascalCase()}}RemoteSource{
  const {{name.pascalCase()}}RemoteSource(this._client);
  final DioApiClient _client;

   Future<Either<AppError, String>> fetchData({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _client.get(
        AppEndpoints.baseUrl,
        cancelToken: cancelToken,
      );
      return right(response['message']);
    } catch (e) {
      if (e is ApiErrorResponse) {
        return left(e);
      } else {
        return left(InternalAppError(message: e.toString()));
      }
    }
  }
}
