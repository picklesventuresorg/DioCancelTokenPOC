import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET("posts/{id}")
  Future<HttpResponse> getPost(
    @Path() String id,
    @DioOptions() RequestOptions? dioOption,
  );
}
