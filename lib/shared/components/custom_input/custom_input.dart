import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_create_flutter/shared/components/custom_input/models/input_config.dart';
import 'package:teste_create_flutter/shared/components/custom_input/models/input_decoration_config.dart';
import 'package:teste_create_flutter/shared/components/custom_input/components/password_visibility_toggle.dart';
import 'package:teste_create_flutter/shared/utils/validators_custom_input.dart';
export 'package:teste_create_flutter/shared/components/custom_input/models/input_config.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final InputType type;
  final TextEditingController? controller;
  final bool shouldValidate;
  final String? Function(String?)? customValidator;
  final String? helperText;
  final String? hintText;
  final Widget? prefixIcon;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final InputDecorationConfig? decorationConfig;
  final bool isRequired;

  const CustomInput({
    super.key,
    required this.label,
    this.type = InputType.text,
    this.controller,
    this.shouldValidate = true,
    this.customValidator,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.textInputAction,
    this.decorationConfig,
    this.isRequired = true,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscureText;
  late InputConfig _inputConfig;

  @override
  void initState() {
    super.initState();
    _inputConfig = InputConfig.fromType(
      widget.type,
      customValidator: widget.customValidator,
    );
    _obscureText = _inputConfig.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: _inputConfig.keyboardType,
      obscureText: _obscureText,
      validator: _getValidator,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    final baseConfig = widget.decorationConfig ??
        InputDecorationConfig(
          labelText: widget.label,
          hintText: widget.hintText,
          helperText: widget.helperText,
          prefixIcon: widget.prefixIcon,
        );

    final suffixIcon = widget.type == InputType.password
        ? PasswordVisibilityToggle(
            isObscured: _obscureText,
            onToggle: _togglePasswordVisibility,
          )
        : baseConfig.suffixIcon;

    return baseConfig.copyWith(suffixIcon: suffixIcon).toInputDecoration();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _getValidator(String? value) {
    if (widget.customValidator != null) {
      return widget.customValidator!(value);
    }

    if (!widget.shouldValidate) {
      return null;
    }

    return _getDefaultValidator(value);
  }

  String? _getDefaultValidator(String? value) {
    switch (widget.type) {
      case InputType.email:
        return ValidatorsCustomInput.email(value);
      case InputType.password:
        return ValidatorsCustomInput.password(
          value,
          isRequired: widget.isRequired,
        );
      case InputType.name:
        return ValidatorsCustomInput.fullName(value);
      case InputType.phone:
        return ValidatorsCustomInput.phone(value);
      case InputType.text:
      case InputType.number:
        return widget.isRequired ? ValidatorsCustomInput.required(value) : null;
    }
  }
}
