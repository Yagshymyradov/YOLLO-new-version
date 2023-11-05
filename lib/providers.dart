import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/apiClient.dart';
import 'data/json_http_client.dart';

final apiBaseUrlProvider = Provider((ref) => 'https://yollo.com.tm/yolloadmin/api/');

final httpClientProvider = Provider(
  (ref) {
    final httpClient = JsonHttpClient();

    // httpClient.dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler){
    //       try{
    //         final authToken = ref.read(provider)
    //       } catch(e){}
    //     }
    //   ),
    // );

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
  ],
);

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
