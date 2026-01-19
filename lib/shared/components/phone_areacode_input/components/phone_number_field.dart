// lib/shared/components/phone_areacode_input/components/phone_number_field.dart

import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_input_config.dart';
import 'package:teste_create_flutter/shared/utils/phone_formatter.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final PhoneInputConfig config;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.onChanged,
    this.config = PhoneInputConfig.defaultConfig,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.text.isNotEmpty) {
        _formatPhoneNumber(widget.controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabledColor =
        widget.config.enabledBorderColor ?? AppTheme.borderColor;
    final focusedColor =
        widget.config.focusedBorderColor ?? AppTheme.primaryPurple;
    final errorColor = widget.config.errorBorderColor ?? AppTheme.errorColor;
    final iconColor = widget.config.iconColor ?? AppTheme.textSecondary;

    return TextFormField(
      controller: widget.controller,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.config.phoneHint,
        prefixIcon: widget.config.phoneIcon != null
            ? Icon(widget.config.phoneIcon, color: iconColor)
            : null,
        constraints: BoxConstraints(minHeight: widget.config.minHeight),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: _buildBorder(enabledColor),
        enabledBorder: _buildBorder(enabledColor),
        focusedBorder: _buildBorder(focusedColor),
        errorBorder: _buildBorder(errorColor),
        focusedErrorBorder: _buildBorder(errorColor),
      ),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        _formatPhoneNumber(value);
        widget.onChanged?.call(value);
      },
    );
  }

  void _formatPhoneNumber(String value) {
    final formatted = PhoneFormatter.format(value);
    if (widget.controller.text != formatted) {
      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: widget.config.borderWidth,
      ),
      borderRadius: BorderRadius.circular(widget.config.borderRadius),
    );
  }
}
