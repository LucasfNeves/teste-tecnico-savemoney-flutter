import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/shared/components/custom_input.dart';
import 'package:teste_create_flutter/shared/components/title_subtitle_centralized.dart';
import 'package:teste_create_flutter/shared/layouts/login_register-layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginRegisterLayout(
      child: Form(
        key: GlobalKey<FormState>(),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              onPressed: () {},
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                // Navegar para outra tela
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Não tem cadastro?',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
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
    );
  }
}
