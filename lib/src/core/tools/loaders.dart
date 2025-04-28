import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class Loaders {
  static Future<String> fromLocal(String path, {bool cache = true}) async =>
      rootBundle.loadString(path, cache: cache);

  static Future<String> fromNetwork(String href, {Dio? dioClient}) async =>
      (await (dioClient ?? Dio()).get(href)).data.toString();
}
