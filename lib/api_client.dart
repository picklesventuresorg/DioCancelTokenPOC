import 'package:dio/dio.dart';
import 'package:dio_cancel_token_poc/http_header_const.dart';

class ApiClient {
  static ApiClient? instance;
  ApiClient._();

  factory ApiClient() {
    return instance ??= ApiClient._();
  }
  Dio getDio(String? baseUrls) {
    var dio = Dio(BaseOptions(
        baseUrl: baseUrls!,
        connectTimeout:
            const Duration(milliseconds: HttpHeadersConst.kConnectTimeOut),
        receiveTimeout:
            const Duration(milliseconds: HttpHeadersConst.kReceiveTimeOut),
        contentType: HttpHeadersConst.kApplicationJson,
        headers: {
          HttpHeadersConst.kHeaderAccept: HttpHeadersConst.kApplicationJson
        }));

    /// For debug only
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
    return dio;
  }
}
