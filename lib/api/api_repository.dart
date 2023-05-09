import 'dart:async';

import 'package:mobilefirst_flutter/models/models.dart';
import 'package:mobilefirst_flutter/models/response/users_response.dart';

import '../models/news_api_model.dart';
import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login('/api/login', data);
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(res.body);
    }
  }

  Future<RegisterResponse?> register(RegisterRequest data) async {
    final res = await apiProvider.register('/api/register', data);
    if (res.statusCode == 200) {
      return RegisterResponse.fromJson(res.body);
    }
  }

  Future<NewsApiModel?> getUsers() async {
    final res = await apiProvider.getNews('/v2/everything?q=keyword&apiKey=bf66ffcecd324b39910aa6abf1636b2a');
    if (res.statusCode == 200) {
      return NewsApiModel.fromJson(res.body);
    }
  }
}
