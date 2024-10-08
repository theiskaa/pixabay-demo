import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pixabay_demo/core/app/api.dart';
import 'package:pixabay_demo/core/app/intl.dart';
import 'package:pixabay_demo/core/repositories/pixabay_repository.dart';
import 'package:pixabay_demo/core/repositories/user_repository.dart';
import 'package:pixabay_demo/core/services/pixabay_service.dart';
import 'package:pixabay_demo/core/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class responsible for dependency injection in the application.
///
/// This class uses the `GetIt` package to register and provide instances
/// of services and repositories throughout the app. It ensures that objects
/// like the API client and repositories are created and shared properly.
class Injection {
  /// The instance of `GetIt` used for dependency injection.
  static final instance = GetIt.instance;

  /// Constructor for the `Injection` class. This is const, meaning that the
  /// class is immutable and can be instantiated multiple times without side effects.
  const Injection();

  /// Registers all necessary dependencies for the app.
  ///
  /// This method sets up the injection of services and repositories, such as
  /// the `Dio` instance for network requests and the `UserRepository` for user-related operations.
  /// It uses lazy singleton registration to ensure that the services are only instantiated
  /// when needed (i.e., on the first use).
  static Future<void> initInjections() async {
    instance.registerSingleton<Dio>(dioinstance);
    instance.registerSingleton<Intl>(Intl());
    final localInstance = await SharedPreferences.getInstance();
    instance.registerSingleton<SharedPreferences>(localInstance);

    instance.registerLazySingleton<UserRepository>(() => UserService());
    instance.registerLazySingleton<PixabayRepository>(() => PixabayService());
  }
}
