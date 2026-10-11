import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mental Math',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.goNamed('visualization'),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}