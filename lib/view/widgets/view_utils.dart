import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Utility class for common view-related functions.
class ViewUtils {
  /// Displays a customizable snack bar.
  ///
  /// [context] - BuildContext for locating the Scaffold.
  /// [title] - The primary text to display.
  /// [body] - Optional secondary text.
  /// [color] - Background color of the snack bar. Defaults to redAccent.
  /// [isFloating] - Whether the snack bar is floating or not. Defaults to true.
  /// [sec] - Duration in seconds for which the snack bar is visible.
  static showSnack(
    BuildContext context, {
    required String title,
    String? body,
    Color color = Colors.redAccent,
    bool isFloating = true,
    int sec = 3,
    double? width,
  }) async {
    final snack = SnackBar(
      width: width,
      content: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              if (body == null || body.isEmpty) {
                return Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              }

              return Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    body,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 15,
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
      duration: Duration(seconds: sec),
      margin: width != null ? null : (isFloating ? const EdgeInsets.all(8) : null),
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: isFloating
            ? BorderRadius.circular(8)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  /// Generates a [CupertinoActivityIndicator] widget.
  ///
  /// [context] - BuildContext for theme data.
  /// [size] - Size of the indicator. Optional.
  /// [brh] - Brightness mode (light/dark). Optional, defaults to current theme brightness.
  static Widget loading(
    BuildContext context, {
    double? size,
    Brightness? brh,
  }) {
    final brightness = brh ?? Theme.of(context).brightness;

    return SizedBox(
      height: size,
      width: size,
      child: Theme(
        data: ThemeData(
          cupertinoOverrideTheme: CupertinoThemeData(
            brightness: brightness,
          ),
        ),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}