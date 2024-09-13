import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/models/user.dart';
import 'package:pixabay_demo/core/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that implements the [UserRepository] interface to handle
/// user-related operations such as login, registration, and session management.
///
/// This class makes use of the `Dio` HTTP client to communicate with the
/// backend API and the `SharedPreferences` package to store user session data locally.
/// It also uses the `http_mock_adapter` package for mocking responses during tests or development.
class UserService implements UserRepository {
  /// The key used to store user data in local storage.
  static const String key = 'user';

  final dio = Injection.instance.get<Dio>();
  final local = Injection.instance.get<SharedPreferences>();

  /// Logs in a user using the provided [email] and [password].
  ///
  /// It sends a POST request to the `/login` endpoint with the user's credentials.
  /// If the login is successful (status code 200), it returns a [UserModel] containing
  /// the user details and stores the user session locally using `SharedPreferences`.
  /// Otherwise, it returns an appropriate error message in an [Exception].
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

      if (response.statusCode != 200) {
        return (
          null,
          Exception(
              "Login failed: Invalid credentials or server error. Response: ${response.data}"),
        );
      }

      final user = UserModel(email: email, password: password, age: 0);
      await local.setString(key, jsonEncode(user.toJson()));

      return (user, null);
    } on Exception catch (e) {
      return (null, Exception("An error occurred during login: $e"));
    }
  }

  /// Registers a new user with the provided [email], [password], and [age].
  ///
  /// It sends a POST request to the `/register` endpoint with the user's details.
  /// If the registration is successful (status code 200), it returns a [UserModel]
  /// with the registered user details and stores the user session locally using `SharedPreferences`.
  /// If registration fails, it returns an appropriate error message in an [Exception].
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

      if (response.statusCode != 200) {
        return (
          null,
          Exception("Registration failed: Unable to register user. Response: ${response.data}")
        );
      }

      final user = UserModel(email: email, password: password, age: age);
      await local.setString(key, jsonEncode(user.toJson()));
      return (user, null);
    } on Exception catch (e) {
      return (null, Exception("An error occurred during registration: $e"));
    }
  }

  /// Logs out the current user from the system.
  ///
  /// This method removes the user's session data stored locally using `SharedPreferences`.
  ///
  /// Example usage:
  /// ```dart
  /// await userService.logout();
  /// ```
  @override
  Future<void> logout() async => await local.remove(key);

  /// Retrieves the current authenticated user from local storage.
  ///
  /// This method fetches the user session stored in `SharedPreferences`, decodes the user data,
  /// and returns a [UserModel]. If no user data is found or if there's an issue decoding the data,
  /// it returns `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final user = await userService.getUser();
  /// if (user != null) {
  ///   print('Logged in as ${user.email}');
  /// }
  /// ```
  ///
  /// Returns:
  /// - A [UserModel] if the user is found and successfully decoded.
  /// - `null` if no user is found or an error occurs.
  @override
  Future<UserModel?> getUser() async {
    final stringified = local.getString(key);
    if (stringified == null) return null;
    try {
      final parsed = jsonDecode(stringified.toString());
      return UserModel.fromJson(parsed);
    } catch (e) {
      debugPrint("Error decoding user data: $e");
      return null;
    }
  }
}
