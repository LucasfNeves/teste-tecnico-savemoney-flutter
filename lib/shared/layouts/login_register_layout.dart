import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';

class LoginRegisterLayout extends StatelessWidget {
  final Widget child;

  const LoginRegisterLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background-principal.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: SvgPicture.asset(
                    'lib/assets/logo-grande-branco.svg',
                    height: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(AppTheme.globalPadding),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [child],
                      ),
                    ),
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
