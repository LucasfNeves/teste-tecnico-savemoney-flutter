import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_event.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_state.dart';
import 'package:teste_create_flutter/shared/components/custom_input.dart';
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
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthLoginRequested(
                                      _emailController.text,
                                      _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child: state is AuthLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Entrar'),
                  );
                },
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/undefined');
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Não tem cadastro?',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                    children: [
                      TextSpan(
                        text: ' Crie sua conta',
                        style: TextStyle(
                            color: AppTheme.primaryPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
