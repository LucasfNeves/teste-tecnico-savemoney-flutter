import 'package:flutter/material.dart';

class InputConfig {
  final InputType type;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const InputConfig({
    required this.type,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  factory InputConfig.fromType(
    InputType type, {
    String? Function(String?)? customValidator,
  }) {
    switch (type) {
      case InputType.email:
        return InputConfig(
          type: type,
          keyboardType: TextInputType.emailAddress,
          validator: customValidator,
        );
      case InputType.password:
        return InputConfig(
          type: type,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: customValidator,
        );
      case InputType.number:
        return InputConfig(
          type: type,
          keyboardType: TextInputType.number,
          validator: customValidator,
        );
      case InputType.phone:
        return InputConfig(
          type: type,
          keyboardType: TextInputType.phone,
          validator: customValidator,
        );
      case InputType.name:
      case InputType.text:
        return InputConfig(
          type: type,
          keyboardType: TextInputType.text,
          validator: customValidator,
        );
    }
  }

  InputConfig copyWith({
    InputType? type,
    TextInputType? keyboardType,
    bool? obscureText,
    String? Function(String?)? validator,
  }) {
    return InputConfig(
      type: type ?? this.type,
      keyboardType: keyboardType ?? this.keyboardType,
      obscureText: obscureText ?? this.obscureText,
      validator: validator ?? this.validator,
    );
  }
}

enum InputType {
  text,
  email,
  password,
  number,
  phone,
  name,
}
