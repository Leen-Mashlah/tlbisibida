import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api/', headers: {
      'Accept': 'application/json',
    }));
  }

  static Future<Response?> getData(String url,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    return await dio?.get(url, queryParameters: query);
  }

  static Future<Response?> getImage(String url,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    return await dio?.get<List<int>>(url,
        queryParameters: query,
        options: Options(responseType: ResponseType.bytes));
  }

  static Future<Response?> postData(String url, Map<String, dynamic> body,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    return await dio?.post(url, data: body, queryParameters: query);
  }

  static Future<Response?> updateData(String url, Map<String, dynamic> body,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    return await dio?.put(url, data: body, queryParameters: query);
  }

  static Future<Response?> deleteData(String url,
      {Map<String, dynamic>? query, String? token}) async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    return await dio?.delete(url, queryParameters: query);
  }
}
