import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/apiClient.dart';
import 'data/auth_controller.dart';
import 'data/json_http_client.dart';
import 'data/service/preferences.dart';

/// It is an error to use this provider without overriding it's value.
final appPrefsServiceProvider = Provider<AppPrefsService>(
      (ref) => throw UnimplementedError("Can't use this provider without overriding it's value."),
);

final authControllerProvider = StateNotifierProvider<AuthController, UserState?>((ref) {
  final appPrefs = ref.watch(appPrefsServiceProvider);
  final initialState = AuthController.initialState(appPrefs);
  return AuthController(appPrefs, initialState);
});

final httpClientProvider = Provider(
  (ref) {
    final httpClient = JsonHttpClient();

    httpClient.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler){
          try{
            final authToken = ref.read(authControllerProvider)?.authToken;
            if(authToken != null){
              options.headers[HttpHeaders.authorizationHeader] = 'Bearer $authToken';
            }
          } catch(e){
            //ignored
          }
          handler.next(options);
        },
      ),
    );

    ref.listen(
      apiBaseUrlProvider,
      (previous, next) {
        final apiBaseUrl = next;
        httpClient.dio.options.baseUrl = apiBaseUrl;
      },
      fireImmediately: true,
    );

    return httpClient;
  },
  dependencies: [
    apiBaseUrlProvider,
    authControllerProvider,
  ],
);

final apiBaseUrlProvider = Provider((ref) {
  // return 'http://216.250.10.237:8003/api/v1/';
  return 'https://yollo.com.tm/yolloadmin/api/';
});

final apiClientProvider = Provider(
  (ref) => ApiClient(
    ref.watch(httpClientProvider),
  ),
  dependencies: [httpClientProvider],
);

final regionsHiProvider = FutureProvider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getRegionsHi();
});

final regionsCityProvider = FutureProvider.family((ref, String hiRegion) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getRegionsCity(hiRegion);
});
