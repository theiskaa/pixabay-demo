import 'package:flutter/cupertino.dart';

/// A custom button widget that provides an opacity effect on press.
///
/// This button is designed to wrap around any child widget and apply
/// an opacity change when pressed. It extends the StatelessWidget.
class OpacityButton extends StatelessWidget {
  /// The widget to display inside the button.
  final Widget child;

  /// The callback function to be called when the button is tapped.
  /// If null, the button will be disabled.
  final void Function()? onTap;

  /// The padding around the button. By default, it's set to EdgeInsets.zero.
  final EdgeInsets padding;

  /// The opacity value to be applied when the button is pressed.
  /// Default value is 0.7.
  final double opacityValue;

  final double? minSize;

  /// Constructs an [OpacityButton].
  ///
  /// Requires [child] widget to be displayed inside the button.
  /// Optionally, [onTap] callback, [padding], and [opacityValue] can be provided.
  const OpacityButton({
    super.key,
    required this.child,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.opacityValue = 0.7,
    this.minSize = kMinInteractiveDimensionCupertino,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: minSize,
      padding: padding,
      pressedOpacity: opacityValue,
      onPressed: onTap,
      child: child,
    );
  }
}
