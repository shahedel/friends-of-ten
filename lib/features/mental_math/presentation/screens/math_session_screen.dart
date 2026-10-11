import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/abacus.dart';

class MathSessionScreen extends StatefulWidget {
  const MathSessionScreen({super.key});

  @override
  State<MathSessionScreen> createState() => _MathSessionScreenState();
}

class _MathSessionScreenState extends State<MathSessionScreen> {
  int _value = 0;
  int _resetCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              Text(
                '$_value',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Abacus(
                key: ValueKey(_resetCount),
                onValueChanged: (v) => setState(() => _value = v),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() {
                      _resetCount++;
                      _value = 0;
                    }),
                    child: const Text('إعادة'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.goNamed('results'),
                    child: const Text('خلصت'),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
