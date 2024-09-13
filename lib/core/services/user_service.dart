import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/models/user.dart';
import 'package:pixabay_demo/core/repositories/user_repository.dart';

/// A service that implements the [UserRepository] interface to handle
/// user-related operations such as login and registration.
///
/// This class makes use of the `Dio` HTTP client to communicate with the
/// backend API. It also uses the `http_mock_adapter` package for mocking
/// responses during tests or development.
class UserService implements UserRepository {
  /// A reference to the injected [Dio] instance used for making HTTP requests.
  final dio = Injection.getinstance.get<Dio>();

  /// Logs in a user using the provided [email] and [password].
  ///
  /// It sends a POST request to the `/login` endpoint with the user's credentials.
  /// If the login is successful (status code 200), it returns a [UserModel] containing
  /// the user details. Otherwise, it returns an appropriate error message in an [Exception].
  ///
  /// A mock response is used during testing with `http_mock_adapter` to simulate a successful login.
  ///
  /// Returns:
  /// - A [UserModel] if login succeeds.
  /// - An [Exception] if an error occurs during the login process.
  @override
  Future<(UserModel?, Exception?)> login(String email, String password) async {
    // Mock response setup for testing purposes.
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost(
      '/login',
      (server) => server.reply(200, null, delay: const Duration(seconds: 1)),
    );

    try {
      final response = await dio.post('/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        return (UserModel(email: email, password: password, age: 0), null);
      }

      return (
        null,
        Exception("Login failed: Invalid credentials or server error. Response: ${response.data}"),
      );
    } on Exception catch (e) {
      return (null, Exception("An error occurred during login: $e"));
    }
  }

  /// Registers a new user with the provided [email], [password], and [age].
  ///
  /// It sends a POST request to the `/register` endpoint with the user's details.
  /// If the registration is successful (status code 200), it returns a [UserModel]
  /// with the registered user details. If registration fails, it returns an appropriate error message.
  ///
  /// A mock response is used during testing with `http_mock_adapter` to simulate a successful registration.
  ///
  /// Returns:
  /// - A [UserModel] if registration succeeds.
  /// - An [Exception] if an error occurs during the registration process.
  @override
  Future<(UserModel?, Exception?)> register(String email, String password, int age) async {
    // Mock response setup for testing purposes.
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost(
      '/register',
      (server) => server.reply(200, null, delay: const Duration(seconds: 1)),
    );

    try {
      final response = await dio.post('/register', data: {
        "email": email,
        "password": password,
        "age": age,
      });

      if (response.statusCode == 200) {
        return (UserModel(email: email, password: password, age: age), null);
      }

      return (
        null,
        Exception("Registration failed: Unable to register user. Response: ${response.data}")
      );
    } on Exception catch (e) {
      return (null, Exception("An error occurred during registration: $e"));
    }
  }
}
