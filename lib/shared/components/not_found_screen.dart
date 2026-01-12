import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Página não encontrada',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            SvgPicture.asset(
              'lib/assets/page-not-found.svg',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
