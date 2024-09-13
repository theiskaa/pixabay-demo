export 'app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/core/app/injection.dart';
import 'package:pixabay_demo/core/state/app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The `AppCubit` class is a state manager for the application, particularly focusing on managing
/// and updating the application's preferences such as language settings.
///
/// It extends `Cubit<AppCubitState>`, leveraging the Cubit package for state management.
/// This cubit maintains the state of application preferences and provides methods to initialize
/// and update these preferences.
class AppCubit extends Cubit<AppCubitState> {
  final local = Injection.instance.get<SharedPreferences>();

  /// Constructor that initializes the `AppCubit` with its default state.
  AppCubit() : super(const AppCubitState());

  /// Initializes the application's preferences by retrieving the saved language setting.
  ///
  /// This method reads the 'lang' key from local storage and updates the cubit state with
  /// the retrieved language preference. If no language is saved, it defaults to 'en' (English).
  /// It's typically called during application startup to ensure the app respects the user's
  /// saved preferences.
  Future<void> initApp() async {
    final lang = local.getString('lang') ?? 'en';
    emit(state.copyWith(language: lang));
  }

  /// Changes the application's language setting and updates the cubit state.
  ///
  /// [language]: The new language code to be set. This should be a valid language code
  /// (e.g., 'en' for English, 'ka' for Georgian, and 'ru' for Russian).
  ///
  /// This method updates the 'lang' key in local storage with the new language setting
  /// and then emits the updated state to reflect this change. It's typically called when
  /// the user changes the language in the application settings.
  Future<void> changeLang(String language) async {
    await local.setString('lang', language);
    emit(state.copyWith(language: language));
  }
}
