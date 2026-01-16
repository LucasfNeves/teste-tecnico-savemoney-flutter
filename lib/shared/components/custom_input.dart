import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/utils/validators_custom_input.dart';

enum InputType { text, email, password, number, name }

class CustomInput extends StatefulWidget {
  final String label;
  final InputType type;
  final TextEditingController? controller;
  final bool shouldValidate;

  const CustomInput({
    super.key,
    required this.label,
    this.type = InputType.text,
    this.controller,
    this.shouldValidate = true,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: AppTheme.textLabel),
        constraints: const BoxConstraints(minHeight: 56),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.type == InputType.password
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppTheme.textSecondary),
                ),
              )
            : null,
      ),
      keyboardType: _getKeyboardType(),
      obscureText: widget.type == InputType.password ? _obscureText : false,
      validator: _getDefaultValidator,
    );
  }

  String? _getDefaultValidator(String? value) {
    if (!widget.shouldValidate) {
      return null;
    }

    switch (widget.type) {
      case InputType.email:
        return ValidatorsCustomInput.email(value);
      case InputType.password:
        return ValidatorsCustomInput.password(value);
      case InputType.name:
        return ValidatorsCustomInput.fullName(value);
      case InputType.text:
      case InputType.number:
        return ValidatorsCustomInput.required(value);
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.password:
        return TextInputType.visiblePassword;
      case InputType.text:
      case InputType.name:
        return TextInputType.text;
      case InputType.number:
        return TextInputType.number;
    }
  }
}
