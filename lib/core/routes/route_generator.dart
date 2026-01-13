import 'package:flutter/material.dart';
import 'package:teste_create_flutter/presentation/screens/login_screen.dart';
import 'package:teste_create_flutter/presentation/screens/register/register_screen.dart';
import 'package:teste_create_flutter/presentation/screens/splash_screen.dart';
import 'package:teste_create_flutter/presentation/screens/users_list.dart';
import 'package:teste_create_flutter/shared/components/not_found_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.usersList:
        return MaterialPageRoute(builder: (_) => const UsersList());
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        );
    }
  }
}
