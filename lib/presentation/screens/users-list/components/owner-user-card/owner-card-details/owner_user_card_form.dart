import 'package:flutter/material.dart';
import 'package:teste_create_flutter/shared/components/multiple_phone_input.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_data.dart';
import 'package:teste_create_flutter/shared/components/custom_input/custom_input.dart';

class OwnerUserCardForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final List<PhoneData> userPhones;

  final ValueChanged<List<PhoneData>> onPhonesChanged;

  const OwnerUserCardForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.userPhones,
    required this.onPhonesChanged,
  });

  @override
  State<OwnerUserCardForm> createState() => _OwnerUserCardFormState();
}

class _OwnerUserCardFormState extends State<OwnerUserCardForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomInput(
            label: 'Nome Completo',
            type: InputType.name,
            controller: widget.nameController,
          ),
          const SizedBox(height: 20),
          CustomInput(
            label: 'E-mail',
            type: InputType.email,
            controller: widget.emailController,
          ),
          const SizedBox(height: 20),
          CustomInput(
            label: 'Nova Senha (opcional)',
            type: InputType.password,
            controller: widget.passwordController,
            isRequired: false,
          ),
          const SizedBox(height: 20),
          MultiplePhoneInput(
            initialPhones: widget.userPhones,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onPhonesChanged,
          ),
        ],
      ),
    );
  }
}
