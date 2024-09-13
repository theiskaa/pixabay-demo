import 'package:pixabay_demo/core/models/user.dart';

/// An abstract class that defines the contract for user-related operations.
/// This repository interface outlines methods for logging in and registering users.
///
/// Implementations of this repository will handle the logic for interacting
/// with an external service, API, or database to manage user authentication and registration.
abstract class UserRepository {

  /// Attempts to log in a user with the given [email] and [password].
  ///
  /// Returns a `Future` that completes with a tuple containing:
  /// - A [UserModel] if the login is successful, or `null` if there was an error.
  /// - An [Exception] if there was a problem during the login process, or `null` if successful.
  ///
  /// Implementations should handle exceptions related to network issues, authentication failures,
  /// or other errors and return them appropriately.
  ///
  /// Example usage:
  /// ```dart
  /// final (user, error) = await userRepository.login('email@example.com', 'password');
  /// ```
  Future<(UserModel?, Exception?)> login(String email, String password);

  /// Registers a new user with the given [email], [password], and [age].
  ///
  /// Returns a `Future` that completes with a tuple containing:
  /// - A [UserModel] if the registration is successful, or `null` if there was an error.
  /// - An [Exception] if there was a problem during the registration process, or `null` if successful.
  ///
  /// Implementations should handle errors such as invalid data, network issues,
  /// or server-side failures and return exceptions accordingly.
  ///
  /// Example usage:
  /// ```dart
  /// final (user, error) = await userRepository.register('email@example.com', 'password', 25);
  /// ```
  Future<(UserModel?, Exception?)> register(String email, String password, int age);
}
