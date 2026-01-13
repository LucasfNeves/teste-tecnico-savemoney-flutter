import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/auth/auth_event.dart';
import 'package:teste_create_flutter/core/routes/app_routes.dart';
import 'package:teste_create_flutter/shared/components/logout_confirmation_dialog.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: AppTheme.backGroundAppBar,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'lib/assets/logo-pequeno-roxo-preto.svg',
            height: 24,
            fit: BoxFit.contain,
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryPurple),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final authBloc = context.read<AuthBloc>();

                final shouldLogout =
                    await LogoutConfirmationDialog.show(context);

                if (shouldLogout == true) {
                  authBloc.add(AuthLogoutRequested());
                  navigator.pushNamedAndRemoveUntil(
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
                color: AppTheme.primaryPurple,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
