import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class Loaders {
  static Future<String> fromLocal(String path) async =>
      rootBundle.loadString(path);

  static Future<String> fromNetwork(String href, {Dio? dioClient}) async =>
      (await (dioClient ?? Dio()).get(href)).data.toString();
}
