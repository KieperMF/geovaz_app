import 'package:dio/dio.dart';
import 'package:geovaz_app/service_locator.dart';
import 'package:result_dart/result_dart.dart';

class GeoVazClient {
  final _dio = sl<Dio>();

  AsyncResult<Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) => _makeRequest(
    () => _dio.get(
      path,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    ),
  );

  AsyncResult<Response> post(
    String path, {
    Map<String, String>? headers,
    dynamic data,
    dynamic contentType,
  }) => _makeRequest(
    () => _dio.post(
      path,
      data: data,
      options: Options(headers: headers, contentType: contentType),
    ),
  );

  AsyncResult<Response> _makeRequest(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return Success(response);
    } on DioException catch (e) {
      return Failure((e));
    }
  }
}
