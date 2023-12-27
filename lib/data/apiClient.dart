import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yollo/data/response_model.dart';

import 'json_http_client.dart';
import 'response.dart';

extension Endpoint on Never {
  static const String login = 'user/apilogin/';

  static const String logOut = 'user/apilogout/';

  static const String createUser = 'user/createuserapi/';

  static const String regionsHi = 'box/regionshi';

  static const String ordersBox = 'box/boxes';

  static String regionsCity(String hiRegion) => 'box/regionscity?region_hi=$hiRegion';
}

class ApiClient {
  final JsonHttpClient _httpClient;

  ApiClient(this._httpClient);

  Future<LoginResponse> signIn({
    required String username,
    required String password,
  }) {
    final postData = <String, dynamic>{
      'username': username,
      'password': password,
    };
    return _httpClient.post(
      Endpoint.login,
      body: postData,
      mapper: (dynamic data) => LoginResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<LoginResponse> signUp({
    required String password,
    required String name,
    required String phone,
    required int regionHi,
    required int regionCity,
    required String address,
  }) {
    final postData = <String, dynamic>{
      'password': password,
      'name': name,
      'phone': phone,
      'region_hi': regionHi,
      'region_city': regionCity,
      'address': address,
    };
    return _httpClient.post(
      Endpoint.createUser,
      body: postData,
      mapper: (dynamic data) => LoginResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<LoginResponse> logOut(String? accessToken) {
    return _httpClient.post(
      Endpoint.logOut,
      mapper: (dynamic data) => LoginResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Regions> getRegionsHi() {
    return _httpClient.get(
      Endpoint.regionsHi,
      mapper: (dynamic data) => Regions.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Regions> getRegionsCity(String hiRegion) {
    return _httpClient.get(
      Endpoint.regionsCity(hiRegion),
      mapper: (dynamic data) => Regions.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<OrderBox> getOrdersBox() {
    return _httpClient.get(
      Endpoint.ordersBox,
      mapper: (dynamic data) => OrderBox.fromJson(data as Map<String, dynamic>),
    );
  }
}
