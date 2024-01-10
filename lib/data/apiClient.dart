import 'dart:developer';
import 'dart:io';

import 'json_http_client.dart';
import 'response.dart';

extension Endpoints on Never {
  static const String login = 'user/apilogin/';

  static const String logOut = 'user/apilogout/';

  static const String refreshToken = 'token/refresh/';

  static const String createUser = 'user/createuserapi/';

  static const String regionsHi = 'box/regionshi';

  static const String ordersBox = 'box/boxes';

  static String news(String language) => 'box/notification?lang=$language';

  static String ordersBoxById(int id) => 'box/boxes/$id';

  static String regionsCity(String hiRegion) => 'box/regionscity?region_hi=$hiRegion';
}

class ApiClient {
  final JsonHttpClient _httpClient;

  ApiClient(this._httpClient);

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) {
    final postData = <String, dynamic>{
      'username': username,
      'password': password,
    };
    return _httpClient.post(
      Endpoints.login,
      body: postData,
      mapper: (dynamic data) {
        return LoginResponse.fromJson(data as Map<String, dynamic>);
      },
    );
  }

  //TODO: DO IT WITH CORRECT WAY
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
      Endpoints.createUser,
      body: postData,
      mapper: (dynamic data) => LoginResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<RefreshTokenResponse> refreshToken(String token) async {
    return _httpClient.post(
      Endpoints.refreshToken,
      body: <String, dynamic>{
        'refresh': token,
      },
      mapper: (dynamic data) => RefreshTokenResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<LoginResponse> logOut(String? accessToken) {
    return _httpClient.post(
      Endpoints.logOut,
      mapper: (dynamic data) => LoginResponse.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Regions> getRegionsHi() {
    return _httpClient.get(
      Endpoints.regionsHi,
      mapper: (dynamic data) => Regions.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<Regions> getRegionsCity(String hiRegion) {
    return _httpClient.get(
      Endpoints.regionsCity(hiRegion),
      mapper: (dynamic data) => Regions.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<OrderData> getOrdersBox() {
    return _httpClient.get(
      Endpoints.ordersBox,
      mapper: (dynamic data) => OrderData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<OrderDetails> getOrdersBoxById(int id) {
    return _httpClient.get(
      Endpoints.ordersBoxById(id),
      mapper: (dynamic data) => OrderDetails.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<CreateOrderBox> createOrderBox({
    required CreateOrderBox createOrderBox,
    String? img,
    File? file,
  }) async {
    return _httpClient.post(
      Endpoints.ordersBox,
      body: createOrderBox.toJson(),
      mapper: (dynamic data) => CreateOrderBox.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<NewsResponse> getNews(String language) {
    return _httpClient.get(
      Endpoints.news(language),
      mapper: (dynamic data) => NewsResponse.fromJson(data as Map<String, dynamic>),
    );
  }
}
