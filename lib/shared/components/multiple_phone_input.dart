// lib/shared/components/multiple_phone_input.dart

import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_data.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/phone_input_with_area_code.dart';
import 'package:teste_create_flutter/shared/components/secundary_button.dart';

class MultiplePhoneInput extends StatefulWidget {
  final ValueChanged<List<PhoneData>> onChanged;
  final List<PhoneData>? initialPhones;
  final int maxPhones;
  final String firstPhoneLabel;
  final String additionalPhoneLabel;
  final AutovalidateMode? autovalidateMode;

  const MultiplePhoneInput({
    super.key,
    required this.onChanged,
    this.initialPhones,
    this.maxPhones = 5,
    this.firstPhoneLabel = 'Telefone',
    this.additionalPhoneLabel = 'Telefone',
    this.autovalidateMode,
  });

  @override
  State<MultiplePhoneInput> createState() => _MultiplePhoneInputState();
}

class _MultiplePhoneInputState extends State<MultiplePhoneInput> {
  late List<PhoneData> _phones;

  @override
  void initState() {
    super.initState();
    _initializePhones();
  }

  void _initializePhones() {
    if (widget.initialPhones != null && widget.initialPhones!.isNotEmpty) {
      _phones = List.from(widget.initialPhones!);
    } else {
      _phones = [const PhoneData.empty()];
    }
  }

  @override
  void didUpdateWidget(MultiplePhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialPhones != oldWidget.initialPhones) {
      _initializePhones();
    }
  }

  bool get _canAddPhone => _phones.length < widget.maxPhones;
  bool get _canRemovePhone => _phones.length > 1;

  void _addPhone() {
    if (_canAddPhone) {
      setState(() {
        _phones.add(const PhoneData.empty());
      });
    }
  }

  void _removePhone(int index) {
    if (_canRemovePhone) {
      setState(() {
        _phones.removeAt(index);
        widget.onChanged(_phones);
      });
    }
  }

  void _updatePhone(int index, PhoneData phoneData) {
    setState(() {
      _phones[index] = phoneData;
      widget.onChanged(_phones);
    });
  }

  String _getPhoneLabel(int index) {
    if (index == 0) {
      return widget.firstPhoneLabel;
    }
    return '${widget.additionalPhoneLabel} ${index + 1}';
  }

  bool _isRequired(int index) {
    if (index == 0) return true;

    final phone = _phones[index];
    return phone.areaCode.isNotEmpty || phone.number.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildPhoneFields(),
        if (_canAddPhone) ...[
          const SizedBox(height: 16),
          _buildAddButton(),
        ],
      ],
    );
  }

  List<Widget> _buildPhoneFields() {
    return List.generate(_phones.length, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: index < _phones.length - 1 ? 16 : 0),
        child: _buildPhoneField(index),
      );
    });
  }

  Widget _buildPhoneField(int index) {
    final isFirstPhone = index == 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PhoneInputWithAreaCode(
            key: ValueKey('phone_$index'),
            label: _getPhoneLabel(index),
            isRequired: _isRequired(index),
            initialValue: _phones[index],
            autovalidateMode: widget.autovalidateMode,
            onChanged: (phoneData) => _updatePhone(index, phoneData),
          ),
        ),
        if (!isFirstPhone) _buildRemoveButton(index),
      ],
    );
  }

  Widget _buildRemoveButton(int index) {
    return SizedBox(
      width: 48,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: IconButton(
          onPressed: () => _removePhone(index),
          icon: const Icon(Icons.remove_circle_outline),
          color: AppTheme.errorRed,
          tooltip: 'Remover telefone',
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return SecundaryButton(
      icon: Icons.add_circle_outline,
      label: 'Adicionar telefone',
      onPressed: _addPhone,
    );
  }
}
