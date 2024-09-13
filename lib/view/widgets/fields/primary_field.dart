import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixabay_demo/view/widgets/colors.dart';
import 'package:pixabay_demo/view/widgets/buttons/opacity_button.dart';

/// A text field made for the authentication pages.
///
/// Has custom user-interface implementation that wouldn't
/// be applied for other field-usage cases.
class PrimaryField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final GlobalKey<FormState> formKey;
  final String? hint;
  final String? label;
  final String? Function(String?)? validate;
  final void Function(String)? onChange;
  final Radius borderRadius;
  final double widthFactor;
  final bool obscureText;
  final bool autoSize;
  final bool disableLabel;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int? maxLine;

  const PrimaryField({
    super.key,
    required this.controller,
    required this.formKey,
    this.focusNode,
    this.hint,
    this.label,
    this.validate,
    this.onChange,
    this.borderRadius = const Radius.circular(10),
    this.widthFactor = .85,
    this.obscureText = false,
    this.autoSize = true,
    this.disableLabel = false,
    this.inputType,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLine = 1,
  });

  @override
  State<StatefulWidget> createState() => _PrimaryFieldState();
}

class _PrimaryFieldState extends State<PrimaryField> {
  bool _obscure = false;

  @override
  void initState() {
    _obscure = widget.obscureText;
    super.initState();
  }

  InputBorder enabled() => OutlineInputBorder(
        borderRadius: BorderRadius.all(widget.borderRadius),
        borderSide: borderSide(),
      );

  InputBorder focused([Color? color]) => OutlineInputBorder(
        borderRadius: BorderRadius.all(widget.borderRadius),
        borderSide: borderSide(color),
      );

  // Generates border-side object. According to
  // widget's [controller] and [focusNode].
  BorderSide borderSide([Color? color]) {
    final focused = widget.focusNode?.hasPrimaryFocus ?? false;
    Color? sc = color ?? (focused ? null : Theme.of(context).primaryColor.withOpacity(.2));
    if (sc == null) return const BorderSide();
    return BorderSide(color: sc);
  }

  // Automatically generates the obscure-text enabler/disabler
  // button in case of [widget]'s [obscureText] being true.
  Widget? suffixIcon() {
    if (!widget.obscureText) return null;
    return OpacityButton(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () => setState(() => _obscure = !_obscure),
      child: Center(
        child: Icon(
          _obscure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
          size: 16,
          color: AppColors.baseBlue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final field = Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!widget.disableLabel)
              Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.label ?? '',
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 3.5),
              ]),
            TextFormField(
              maxLines: widget.maxLine,
              readOnly: widget.readOnly,
              controller: widget.controller,
              validator: widget.validate,
              keyboardType: widget.inputType,
              inputFormatters: widget.inputFormatters,
              obscureText: _obscure,
              onChanged: (value) {
                widget.formKey.currentState?.validate();
                widget.onChange?.call(value);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: focused(),
                focusedErrorBorder: focused(Colors.red),
                border: enabled(),
                enabledBorder: enabled(),
                errorBorder: enabled(),
                disabledBorder: enabled(),
                suffixIcon: suffixIcon(),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 50,
                  maxWidth: 50,
                ),
                errorMaxLines: 3,
              ),
            ),
          ],
        ),
      );

      if (!widget.autoSize) return field;
      return FractionallySizedBox(
        widthFactor: widget.widthFactor,
        child: field,
      );
    });
  }
}
