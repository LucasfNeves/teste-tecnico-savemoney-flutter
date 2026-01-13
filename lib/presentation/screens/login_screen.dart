import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_event.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_state.dart';
import 'package:teste_create_flutter/shared/components/custom_input.dart';
import 'package:teste_create_flutter/shared/components/primary_button.dart';
import 'package:teste_create_flutter/shared/components/navigation_text.dart';
import 'package:teste_create_flutter/shared/components/title_subtitle_centralized.dart';
import 'package:teste_create_flutter/shared/layouts/login_register_layout.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: "Login realizado com sucesso!"),
          );
          Navigator.pushReplacementNamed(context, '/users-list');
        } else if (state is AuthLoginError) {
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
              const TitleSubtitleCentralized(
                title: 'Acessar conta',
                subtitle: 'Entre com as suas credenciais',
              ),
              const SizedBox(height: 52),
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
              const SizedBox(height: 40),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => 
                    previous.runtimeType != current.runtimeType,
                builder: (context, state) {
                  return PrimaryButton(
                    text: 'Entrar',
                    isLoading: state is AuthLoading,
                    onPressed: state is AuthLoading ? null : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                _emailController.text.trim(),
                                _passwordController.text,
                              ),
                            );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
              NavigationText(
                normalText: 'Não tem cadastro?',
                highlightText: 'Crie sua conta',
                onTap: () => Navigator.pushNamed(context, '/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
