import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';
import 'package:pixabay_demo/view/widgets/view_utils.dart';

/// A customizable base button widget.
///
/// This widget wraps an [ElevatedButton] providing additional customization options like margin,
/// padding, border radius, border side, and background color. It is designed to be reused across
/// the application for consistency in button styles.
class BaseButton extends StatelessWidget {
  /// The widget to display inside the button.
  final Widget title;

  /// The callback function to be executed when the button is tapped.
  final void Function()? onTap;

  /// The margin around the button.
  final EdgeInsets margin;

  /// The padding inside the button.
  final EdgeInsets padding;

  /// The border radius of the button.
  final Radius radius;

  /// The border side of the button. Defaults to [BorderSide.none].
  final BorderSide border;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The size of base button.
  final Size? size;

  final double? elevation;

  const BaseButton({
    super.key,
    required this.title,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(12),
    this.radius = const Radius.circular(8),
    this.border = BorderSide.none,
    this.backgroundColor = AppColors.baseBlue,
    this.size,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          maximumSize:
              size == null ? null : WidgetStateProperty.all(Size.fromHeight(size?.height ?? 40)),
          minimumSize: size == null ? null : WidgetStateProperty.all(Size(size?.width ?? 130, 0)),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(radius), side: border),
          ),
          elevation: WidgetStateProperty.all(elevation),
        ),
        child: Padding(padding: padding, child: Center(child: title)),
      ),
    );
  }
}

/// A [BaseButton] that integrates with Bloc for loading state management.
///
/// This button will display a loading indicator based on the Bloc state, making it suitable
/// for operations that require asynchronous processing like API calls.
class BaseButtonBloced<B extends BlocBase<S>, S> extends StatelessWidget {
  /// The Bloc associated with this button, used to determine the loading state.
  final B? bloc;

  /// A function that determines whether the current state represents loading.
  final bool Function(S) isLoading;

  /// The widget to display inside the button.
  final Widget title;

  /// The callback function to be executed when the button is tapped.
  final void Function()? onTap;

  /// The margin around the button.
  final EdgeInsets margin;

  /// The padding inside the button.
  final EdgeInsets padding;

  /// The border radius of the button.
  final Radius radius;

  /// The border side of the button. Defaults to [BorderSide.none].
  final BorderSide border;

  /// The background color of the button. Defaults to a predefined color [AppColors.baseBlue].
  final Color? backgroundColor;

  final Brightness brh;

  const BaseButtonBloced({
    super.key,
    this.bloc,
    required this.isLoading,
    required this.title,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(8),
    this.radius = const Radius.circular(10),
    this.border = BorderSide.none,
    this.backgroundColor = AppColors.baseBlue,
    this.brh = Brightness.light,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onTap: onTap,
      margin: margin,
      padding: padding,
      radius: radius,
      border: border,
      backgroundColor: backgroundColor,
      title: Padding(
        padding: const EdgeInsets.all(3),
        child: BlocBuilder<B, S>(
          bloc: bloc,
          builder: (context, state) {
            if (!isLoading(state)) return title;
            return ViewUtils.loading(context, brh: brh);
          },
        ),
      ),
    );
  }
}
