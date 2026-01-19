import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_data.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_input_config.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/components/area_code_field.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/components/phone_number_field.dart';
import 'package:teste_create_flutter/shared/utils/validators_custom_input.dart';

class PhoneInputWithAreaCode extends StatefulWidget {
  final PhoneData? initialValue;
  final ValueChanged<PhoneData>? onChanged;
  final String label;
  final bool isRequired;
  final PhoneInputConfig? config;
  final TextStyle? labelStyle;
  final String? Function(PhoneData phoneData)? customValidator;

  final AutovalidateMode? autovalidateMode;

  const PhoneInputWithAreaCode({
    super.key,
    this.initialValue,
    this.onChanged,
    required this.label,
    this.isRequired = false,
    this.config,
    this.labelStyle,
    this.customValidator,
    this.autovalidateMode,
  });

  @override
  State<PhoneInputWithAreaCode> createState() => _PhoneInputWithAreaCodeState();
}

class _PhoneInputWithAreaCodeState extends State<PhoneInputWithAreaCode> {
  late TextEditingController _areaCodeController;
  late TextEditingController _numberController;
  late PhoneInputConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config ?? PhoneInputConfig.defaultConfig;
    _initializeControllers();
  }

  void _initializeControllers() {
    final initialValue = widget.initialValue ?? const PhoneData.empty();
    _areaCodeController = TextEditingController(text: initialValue.areaCode);
    _numberController = TextEditingController(text: initialValue.number);
  }

  @override
  void didUpdateWidget(PhoneInputWithAreaCode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.config != oldWidget.config) {
      _config = widget.config ?? PhoneInputConfig.defaultConfig;
    }

    final oldValue = oldWidget.initialValue ?? const PhoneData.empty();
    final newValue = widget.initialValue ?? const PhoneData.empty();

    if (oldValue != newValue) {
      _areaCodeController.text = newValue.areaCode;
      _numberController.text = newValue.number;
    }
  }

  PhoneData get _currentPhoneData => PhoneData(
        areaCode: _areaCodeController.text,
        number: _numberController.text,
      );

  void _handleChange() {
    widget.onChanged?.call(_currentPhoneData);
  }

  String? _validator(String? value) {
    if (!widget.isRequired) return null;

    if (widget.customValidator != null) {
      return widget.customValidator!(_currentPhoneData);
    }

    return ValidatorsCustomInput.phoneWithAreaCode(
      _areaCodeController.text,
      _numberController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        const SizedBox(height: 8),
        _buildInputRow(),
      ],
    );
  }

  Widget _buildLabel() {
    final defaultStyle = widget.labelStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
        );

    return Text(widget.label, style: defaultStyle);
  }

  Widget _buildInputRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AreaCodeField(
          controller: _areaCodeController,
          onChanged: _handleChange,
          config: _config,
          validator: _validator,
          autovalidateMode: widget.autovalidateMode,
        ),
        SizedBox(width: _config.spacing),
        Expanded(
          child: PhoneNumberField(
            controller: _numberController,
            onChanged: (_) => _handleChange(),
            config: _config,
            validator: _validator,
            autovalidateMode: widget.autovalidateMode,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _areaCodeController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
