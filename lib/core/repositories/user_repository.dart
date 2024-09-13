import 'package:pixabay_demo/core/models/user.dart';

/// An abstract class that defines the contract for user-related operations.
/// This repository interface outlines methods for logging in, registering, logging out, 
/// and retrieving the current user information.
///
/// Implementations of this repository will handle the logic for interacting
/// with an external service, API, or database to manage user authentication, registration, 
/// session management, and retrieving user data.
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

  /// Logs out the current user from the system.
  ///
  /// This method will terminate the user's session, clear any relevant authentication tokens,
  /// and reset any user-specific data related to the current session. It does not return any value.
  ///
  /// Implementations should ensure that any network, token, or session clearing actions are
  /// performed to effectively log the user out.
  ///
  /// Example usage:
  /// ```dart
  /// await userRepository.logout();
  /// ```
  Future<void> logout();

  /// Retrieves the current authenticated user.
  ///
  /// This method returns a `Future` that completes with a nullable [UserModel] representing the current user.
  /// The method may throw an exception if the user is not authenticated or if there's an issue
  /// retrieving the user data.
  ///
  /// This is useful for retrieving the logged-in user's information (e.g., after login or app restart).
  ///
  /// Example usage:
  /// ```dart
  /// final user = await userRepository.getUser();
  /// ```
  Future<UserModel?> getUser();
}