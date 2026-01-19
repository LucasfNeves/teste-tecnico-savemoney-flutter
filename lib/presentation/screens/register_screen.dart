import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/register/register_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/register/register_event.dart';
import 'package:teste_create_flutter/presentation/blocs/register/register_state.dart';
import 'package:teste_create_flutter/shared/components/multiple_phone_input.dart';
import 'package:teste_create_flutter/shared/components/primary_button.dart';
import 'package:teste_create_flutter/shared/components/navigation_text.dart';
import 'package:teste_create_flutter/shared/components/title_subtitle_centralized.dart';
import 'package:teste_create_flutter/shared/layouts/login_register_layout.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../shared/components/custom_input/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  List<Map<String, dynamic>> _phones = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                  message: "Cadastro realizado com sucesso!"),
            );
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is RegisterError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: state.message),
            );
          }
        },
        child: LoginRegisterLayout(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const TitleSubtitleCentralized(
                  title: 'Criar conta',
                  subtitle: 'Preencha os dados para criar sua conta',
                ),
                const SizedBox(height: 52),
                CustomInput(
                  label: 'Nome Completo',
                  type: InputType.name,
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'E-mail',
                  type: InputType.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Senha',
                  type: InputType.password,
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                MultiplePhoneInput(
                  onChanged: (phones) {
                    setState(() {
                      _phones = phones;
                    });
                  },
                ),
                const SizedBox(height: 40),
                Builder(
                  builder: (context) {
                    final state = context.watch<RegisterBloc>().state;

                    return PrimaryButton(
                      text: 'Cadastrar',
                      isLoading: state is RegisterLoading,
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                      RegisterRequested(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                        telephones: _phones,
                                      ),
                                    );
                              }
                            },
                    );
                  },
                ),
                const SizedBox(height: 40),
                NavigationText(
                  normalText: 'Já tem cadastro?',
                  highlightText: 'Faça login',
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
