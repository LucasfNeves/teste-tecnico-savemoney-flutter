import 'package:flutter/material.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaveMoney',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
