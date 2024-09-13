import 'package:pixabay_demo/core/models/user.dart';

/// A event map for [UserState].
enum UserStateEvent {
  initial,
  login,
  register,
  logout,
}

class UserState {
  final UserModel? user;
  final Map<UserStateEvent, bool> loading;
  final Map<UserStateEvent, String?> error;

  const UserState({
    this.user,
    this.loading = const {
      UserStateEvent.initial: false,
      UserStateEvent.login: false,
      UserStateEvent.register: false,
      UserStateEvent.logout: false,
    },
    this.error = const {},
  });

  UserState copyWith({
    UserModel? user,
    (UserStateEvent, bool)? loading,
    (UserStateEvent, String?)? error,
    bool forceNull = false,
  }) {
    final Map<UserStateEvent, bool> updatedLoading = Map<UserStateEvent, bool>.from(this.loading);
    final Map<UserStateEvent, String?> updatedError = Map<UserStateEvent, String?>.from(this.error);

    if (loading != null) updatedLoading[loading.$1] = loading.$2;
    if (error != null) updatedError[error.$1] = error.$2;
    return UserState(
      user: forceNull ? user : user ?? this.user,
      loading: updatedLoading,
      error: updatedError,
    );
  }
}
