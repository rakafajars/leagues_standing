part of 'api.dart';

class ApiService implements Repository {
  Response response;

  Dio get dio => _dio();
  // set default configs
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: 'https://api-football.azharimm.tk/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: 'application/json',
    );

    var dio = Dio(options);

    dio.interceptors.add(LogginInterceptors());

    return dio;
  }

  String _showException(final error, final stacktrace) {
    print("Exception occurred: $error stackTrace: $stacktrace");
    return "Failed Get Data";
  }

  @override
  Future<ListLeagues> getListLeagues() async {
    try {
      response = await dio.get(
        'leagues',
      );

      return ListLeagues.fromJson(
        response.data,
      );
    } catch (error, stacktrace) {
      throw _showException(error, stacktrace);
    }
  }
}
