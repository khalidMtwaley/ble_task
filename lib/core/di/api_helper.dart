

//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Retrieve token using TokenStorage
//           final token = await TokenStorage.getBearerToken();
//           final languageCode = await HiveHelper.getLanguageCode();

//           // Add Accept-Language header
//           options.headers['Accept-Language'] = languageCode;
//           log('Language Code: $languageCode');

//           // Add Authorization token if available
//           if (token != null) {
//             options.headers[APIConstants.BearerTokenKey] = "Bearer $token";
//             log('Authorization Token: $token');
//           }

//           log('Request URL: ${options.uri.toString()}');
//           log('Request Headers: ${options.headers.toString()}');

//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           if (response.statusCode == 302) {
//             final redirectUrl = response.headers.value('location');
//             log('Received 302 Redirect to: $redirectUrl');
//           }
//           return handler.next(response);
//         },
//         onError: (DioError e, handler) {
//           log('DioError: ${e.message}');
//           if (e.response != null) {
//             log('Error Response Data: ${e.response?.data}');
//             log('Error Response Headers: ${e.response?.headers}');
//           }
//           return handler.next(e);
//         },
//       ),
//     );

//     dio.options.followRedirects = false;
//     dio.options.validateStatus = (status) => status != null && status < 500;

//     return dio;
//   }
// }
