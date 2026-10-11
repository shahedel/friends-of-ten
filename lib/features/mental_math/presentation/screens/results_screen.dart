import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Results (placeholder)'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}