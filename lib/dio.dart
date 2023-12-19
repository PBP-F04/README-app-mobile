import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> get dio async {
    if (_dio == null) {
      if (!kIsWeb) {
        final appDocDir = await getApplicationDocumentsDirectory();
        final appDocPath = appDocDir.path;
        final persistCookieJar = PersistCookieJar(
            ignoreExpires: true, storage: FileStorage("$appDocPath/.cookies/"));
        _dio = Dio(BaseOptions(
            baseUrl: "https://readme-app-production.up.railway.app"));
        _dio!.interceptors.add(CookieManager(persistCookieJar));
      }
    }
    return _dio!;
  }

  static Future<List<Cookie>> getCookies() async {
    var cookieJar = _dio!.interceptors
        .where((element) => element is CookieManager)
        .map((e) => (e as CookieManager).cookieJar)
        .first as PersistCookieJar;

    return cookieJar.loadForRequest(
        Uri.parse("https://readme-app-production.up.railway.app"));
  }
}
