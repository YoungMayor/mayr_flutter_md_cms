import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class Loaders {
  static Future<String> fromLocal(String path) async =>
      rootBundle.loadString(path);

  static Future<String> fromNetwork(String href) async =>
      Dio().get(href).toString();
}
