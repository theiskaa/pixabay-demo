import 'package:pixabay_demo/core/app/intl.dart';

/// Represents the state managed by `AppCubit` in the application.
/// Primarily focuses on the language settings of the app.
class AppCubitState {
  /// The currently selected language code.
  /// It's nullable to accommodate situations where the language might not be set initially.
  final String? language;

  /// Constructs an `AppCubitState` instance with an optional [language] parameter.
  /// [language]: The language code, such as 'en' for English or 'es' for Spanish.
  const AppCubitState({this.language});

  /// Creates a copy of this state with the given [language] or retains the existing one if none is provided.
  /// Useful for updating the state in an immutable way.
  ///
  /// [language]: New language code to update the state with. If null, the current language is retained.
  AppCubitState copyWith({String? language}) {
    return AppCubitState(language: language ?? this.language);
  }

  /// Provides a non-nullable language code.
  /// If the [language] is null, defaults to the first language in the predefined [languages] list.
  ///
  /// This ensures that there's always a valid language code available for the application to use,
  /// preventing potential null reference issues.
  String get languageCode => language ?? languages[0].languageCode;
}
