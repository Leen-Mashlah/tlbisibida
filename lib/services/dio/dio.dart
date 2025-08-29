import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://tusk-project-production.up.railway.app/api/',
        headers: {
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
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    final data = jsonEncode(body);
    print('sending:  ' + body.toString());
    print('encoded: ' + data);

    try {
      return await dio?.post(url, data: data, queryParameters: query);
    } on DioException catch (e) {
      print("Dio Exception, Server response: " + e.response?.data);
    }
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
