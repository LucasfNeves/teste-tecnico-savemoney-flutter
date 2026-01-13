import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teste_create_flutter/core/routes/app_routes.dart';
import 'package:teste_create_flutter/core/routes/route_generator.dart';
import 'package:teste_create_flutter/core/services/auth-service/token_storage.dart';
import 'package:teste_create_flutter/core/services/http_service.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await TokenStorage.loadToken();
  HttpService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: 'SaveMoney',
        theme: AppTheme.lightTheme,
        navigatorKey: HttpService.navigatorKey,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
