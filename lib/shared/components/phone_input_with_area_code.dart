import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class PhoneInputWithAreaCode extends StatefulWidget {
  final String? areaCodeValue;
  final String? numberValue;
  final Function(String areaCode, String number)? onChanged;
  final String label;
  final bool isRequired;

  const PhoneInputWithAreaCode({
    super.key,
    this.areaCodeValue,
    this.numberValue,
    this.onChanged,
    required this.label,
    this.isRequired = false,
  });

  @override
  State<PhoneInputWithAreaCode> createState() => _PhoneInputWithAreaCodeState();
}

class _PhoneInputWithAreaCodeState extends State<PhoneInputWithAreaCode> {
  late TextEditingController _areaCodeController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _areaCodeController = TextEditingController(text: widget.areaCodeValue);
    _numberController = TextEditingController(text: widget.numberValue);
  }

  void _onChanged() {
    widget.onChanged?.call(_areaCodeController.text, _numberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.label}${widget.isRequired ? ' *' : ''}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Campo do código de área
            SizedBox(
              width: 80,
              child: TextFormField(
                controller: _areaCodeController,
                decoration: InputDecoration(
                  hintText: '11',
                  prefixText: '(',
                  suffixText: ')',
                  constraints: const BoxConstraints(minHeight: 56),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChanged: (_) => _onChanged(),
                validator: widget.isRequired
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'DDD obrigatório';
                        }
                        if (value.length != 2) {
                          return 'DDD inválido';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            // Campo do número
            Expanded(
              child: TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: '99999-9999',
                  prefixIcon: Icon(Icons.phone, color: AppTheme.textSecondary),
                  constraints: const BoxConstraints(minHeight: 56),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppTheme.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                onChanged: (_) => _onChanged(),
                validator: widget.isRequired
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Número obrigatório';
                        }
                        if (value.length < 8 || value.length > 9) {
                          return 'Número inválido';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          ],
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
