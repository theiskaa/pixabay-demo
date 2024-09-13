import 'package:dio/dio.dart';

/// BaseOptions for the Dio instance, which includes the base URL for the Pixabay API,
/// query parameters like the API key, and timeouts for connecting and receiving data.
final options = BaseOptions(
  baseUrl: 'https://pixabay.com/api', // The base URL for the Pixabay API.

  /// Query parameters that will be included in every request.
  /// TODO: Retrieve the API key from environment variables to improve security.
  queryParameters: {
    'key': '45961239-09505b101c655041c4df88c2c',
  },

  /// The timeout duration for connecting to the API.
  /// If the connection takes longer than 5 seconds, it will timeout.
  connectTimeout: const Duration(seconds: 5),

  /// The timeout duration for receiving data.
  /// If the response takes longer than 3 seconds to be received, it will timeout.
  receiveTimeout: const Duration(seconds: 3),
);

/// The Dio instance initialized with the base options.
/// This is used to make API calls to the Pixabay service with the predefined options.
final dioinstance = Dio(options);
