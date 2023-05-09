import 'package:mobilefirst_flutter/api/base_provider.dart';
import 'package:mobilefirst_flutter/models/models.dart';
import 'package:get/get.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getNews(String path) {
    return get(path);
  }
}
