// lib/shared/components/phone_areacode_input/components/area_code_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_input_config.dart';

class AreaCodeField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onChanged;
  final PhoneInputConfig config;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const AreaCodeField({
    super.key,
    required this.controller,
    this.onChanged,
    this.config = PhoneInputConfig.defaultConfig,
    this.validator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    final enabledColor = config.enabledBorderColor ?? AppTheme.borderColor;
    final focusedColor = config.focusedBorderColor ?? AppTheme.primaryPurple;
    final errorColor = config.errorBorderColor ?? AppTheme.errorColor;

    return SizedBox(
      width: config.areaCodeWidth,
      child: TextFormField(
        controller: controller,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        validator: validator,
        decoration: InputDecoration(
          hintText: config.areaCodeHint,
          constraints: BoxConstraints(minHeight: config.minHeight),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          border: _buildBorder(enabledColor),
          enabledBorder: _buildBorder(enabledColor),
          focusedBorder: _buildBorder(focusedColor),
          errorBorder: _buildBorder(errorColor),
          focusedErrorBorder: _buildBorder(errorColor),
          errorStyle: const TextStyle(
            color: Colors.transparent,
            fontSize: 12,
            height: 1,
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        onChanged: (_) => onChanged?.call(),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: config.borderWidth,
      ),
      borderRadius: BorderRadius.circular(config.borderRadius),
    );
  }
}
