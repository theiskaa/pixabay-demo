import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/repositories/user_repository.dart';
import 'package:pixabay_demo/core/state/user/user_state.dart';

export 'user_state.dart';

/// A [Cubit] that manages user-related actions and state, such as login,
/// registration, and logout operations. It interacts with the [UserRepository]
/// to perform the necessary operations and updates the [UserState] accordingly.
class UserCubit extends Cubit<UserState> {
  /// The user repository service for managing user operations like login, register, and logout.
  final service = Injection.instance.get<UserRepository>();

  /// Duration after which error states are reset.
  final resetDuration = const Duration(seconds: 1);

  /// Duration between calls and responses for mocking.
  final waitDuration = const Duration(seconds: 1);

  /// Constructor initializes the [UserCubit] with an initial state and
  /// calls the [load] method to load the user from local storage.
  UserCubit() : super(const UserState()) {
    load();
  }

  /// Loads the current user data from local storage.
  ///
  /// This is called when the [UserCubit] is initialized to check if a user
  /// is already logged in. It updates the state with the loaded user data.
  Future<void> load() async {
    emit(state.copyWith(loading: (UserStateEvent.initial, true)));
    final user = await service.getUser();
    emit(state.copyWith(user: user, loading: (UserStateEvent.initial, false)));
  }

  /// Attempts to log in a user with the provided [email] and [password].
  ///
  /// This method interacts with the [UserRepository] to authenticate the user.
  /// It updates the state with the loading indicator while waiting for the result
  /// and updates with the user data if the login is successful. If an error occurs,
  /// it displays the error and resets it after a short delay.
  ///
  /// Parameters:
  /// - [email]: The email of the user attempting to log in.
  /// - [password]: The password of the user attempting to log in.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loading: (UserStateEvent.login, true)));
    final (user, error) = await service.login(email, password);
    await Future.delayed(waitDuration);
    if (error != null) {
      emit(state.copyWith(
        error: (UserStateEvent.login, error.toString()),
        loading: (UserStateEvent.login, false),
      ));
      await Future.delayed(resetDuration);
      emit(state.copyWith(
        error: (UserStateEvent.login, null),
        loading: (UserStateEvent.login, false),
      ));
      return;
    }

    emit(state.copyWith(
      user: user,
      loading: (UserStateEvent.login, false),
      error: (UserStateEvent.login, null),
    ));
  }

  /// Attempts to register a new user with the provided [email], [password], and [age].
  ///
  /// This method interacts with the [UserRepository] to register the user.
  /// It updates the state with the loading indicator while waiting for the result
  /// and updates with the user data if the registration is successful. If an error occurs,
  /// it displays the error and resets it after a short delay.
  ///
  /// Parameters:
  /// - [email]: The email of the user to be registered.
  /// - [password]: The password for the new user.
  /// - [age]: The age of the new user.
  Future<void> register({
    required String email,
    required String password,
    required int age,
  }) async {
    emit(state.copyWith(loading: (UserStateEvent.register, true)));
    final (user, error) = await service.register(email, password, age);
    await Future.delayed(waitDuration);
    if (error != null) {
      emit(state.copyWith(
        error: (UserStateEvent.register, error.toString()),
        loading: (UserStateEvent.register, false),
      ));
      await Future.delayed(resetDuration);
      emit(state.copyWith(
        error: (UserStateEvent.register, null),
        loading: (UserStateEvent.register, false),
      ));
      return;
    }

    emit(state.copyWith(
      user: user,
      loading: (UserStateEvent.register, false),
      error: (UserStateEvent.register, null),
    ));
  }

  /// Logs out the current user and removes their data from local storage.
  ///
  /// This method interacts with the [UserRepository] to log out the user.
  /// It clears the current user data from the state and ensures the user
  /// session is terminated.
  Future<void> logout() async {
    emit(state.copyWith(loading: (UserStateEvent.logout, true)));
    await service.logout();
    emit(state.copyWith(user: null, loading: (UserStateEvent.logout, false), forceNull: true));
  }
}
