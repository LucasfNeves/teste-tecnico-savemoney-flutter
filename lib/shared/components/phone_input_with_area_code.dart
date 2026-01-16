import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/utils/phone_formatter.dart';

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
  bool _hasError = false; // Adicione esta variável

  @override
  void initState() {
    super.initState();
    _areaCodeController = TextEditingController(text: widget.areaCodeValue);
    _numberController = TextEditingController(text: widget.numberValue);
  }

  @override
  void didUpdateWidget(PhoneInputWithAreaCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.areaCodeValue != oldWidget.areaCodeValue) {
      _areaCodeController.text = widget.areaCodeValue ?? '';
    }
    if (widget.numberValue != oldWidget.numberValue) {
      _numberController.text = widget.numberValue ?? '';
    }
  }

  void _formatPhoneNumber(String value) {
    final formatted = PhoneFormatter.format(value);
    _numberController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Importante para alinhamento
          children: [
            Column(
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _areaCodeController,
                    decoration: InputDecoration(
                      hintText: '11',
                      constraints: const BoxConstraints(minHeight: 56),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                _hasError ? Colors.red : AppTheme.borderColor,
                            width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                _hasError ? Colors.red : AppTheme.borderColor,
                            width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    onChanged: (_) => widget.onChanged?.call(
                        _areaCodeController.text, _numberController.text),
                  ),
                ),
                const SizedBox(
                    height: 20), // Espaço para simular a mensagem de erro
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: '9 9999-9999',
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
                validator: widget.isRequired
                    ? (value) {
                        bool hasError = _areaCodeController.text.isEmpty ||
                            value == null ||
                            value.isEmpty;
                        setState(() {
                          _hasError = hasError;
                        });
                        return hasError ? 'O telefone é obrigatório.' : null;
                      }
                    : null,
                onChanged: (value) {
                  _formatPhoneNumber(value);
                  widget.onChanged
                      ?.call(_areaCodeController.text, _numberController.text);
                },
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
