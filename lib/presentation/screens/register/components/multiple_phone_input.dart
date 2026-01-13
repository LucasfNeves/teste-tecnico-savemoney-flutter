import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/screens/register/components/phone_input_with_area_code.dart';
import 'package:teste_create_flutter/shared/components/secundary_button.dart';

class MultiplePhoneInput extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onChanged;

  const MultiplePhoneInput({
    super.key,
    required this.onChanged,
  });

  @override
  State<MultiplePhoneInput> createState() => _MultiplePhoneInputState();
}

class _MultiplePhoneInputState extends State<MultiplePhoneInput> {
  final List<Map<String, dynamic>> _phones = [
    {'area_code': '', 'number': ''}
  ];

  void _addPhone() {
    if (_phones.length < 5) {
      setState(() {
        _phones.add({'area_code': '', 'number': ''});
      });
    }
  }

  void _removePhone(int index) {
    if (_phones.length > 1) {
      setState(() {
        _phones.removeAt(index);
        widget.onChanged(_phones);
      });
    }
  }

  void _updatePhone(int index, String areaCode, String number) {
    final cleanNumber = number.replaceAll(RegExp(r'[^0-9]'), '');

    _phones[index] = {'area_code': areaCode, 'number': cleanNumber};
    widget.onChanged(_phones);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(_phones.length, (index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: PhoneInputWithAreaCode(
                      label: index == 0 ? 'Telefone' : 'Telefone ${index + 1}',
                      isRequired: index == 0,
                      areaCodeValue: _phones[index]['area_code'],
                      numberValue: _phones[index]['number'],
                      onChanged: (areaCode, number) =>
                          _updatePhone(index, areaCode, number),
                    ),
                  ),
                  if (index > 0)
                    if (index > 0)
                      SizedBox(
                        width: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 23),
                          child: IconButton(
                            onPressed: () => _removePhone(index),
                            icon: Icon(Icons.remove_circle_outline,
                                color: AppTheme.errorRed),
                          ),
                        ),
                      ),
                ],
              ),
            ],
          );
        }),
        if (_phones.length < 5) ...[
          const SizedBox(height: 16),
          SecundaryButton(
            icon: Icons.add_circle_outline,
            label: 'Adicionar telefone',
            onPressed: _addPhone,
          ),
        ],
      ],
    );
  }
}
