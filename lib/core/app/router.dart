import 'package:go_router/go_router.dart';
import 'package:pixabay_demo/view/base.dart';

/// Base class for routing in this application.
///
/// Includes two main definitions.
/// - [router] which is the only instance of [GoRouter].
/// - [routes] which is the only instance of defined list of [GoRoute]s.
class AppRouter {
  /// Main instance of [GoRouter].
  static final router = GoRouter(
    initialLocation: '/',
    routes: routes,
  );

  /// Defined routes for [router].
  static final routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const Base(),
    ),
  ];
}
