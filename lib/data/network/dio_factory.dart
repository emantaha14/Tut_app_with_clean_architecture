import 'package:app_with_clean_architecture/app/app_prefs.dart';
import 'package:app_with_clean_architecture/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICTATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    String language = await _appPreferences.getAppLanguage();
    Dio dio = Dio();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICTATION_JSON,
      ACCEPT: APPLICTATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: Constants.apiTimeOut),
      sendTimeout: const Duration(milliseconds: Constants.apiTimeOut),
    );

    if (!kReleaseMode) {
      // is in Release Mode ?
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
