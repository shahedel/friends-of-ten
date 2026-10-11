import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/abacus.dart';

class OnesPracticeScreen extends StatefulWidget {
  const OnesPracticeScreen({super.key});

  @override
  State<OnesPracticeScreen> createState() => _OnesPracticeScreenState();
}

class _OnesPracticeScreenState extends State<OnesPracticeScreen> {
  static const int _needed = 3;
  final Random _rand = Random();

  int _target = 0;
  int _round = 0;
  int _correct = 0;
  bool _justSolved = false;

  @override
  void initState() {
    super.initState();
    _target = _newTarget();
  }

  int _newTarget() {
    int n;
    do {
      n = 1 + _rand.nextInt(9);
    } while (n == _target);
    return n;
  }

  void _onValue(int value) {
    if (_justSolved || value != _target) return;
    setState(() {
      _justSolved = true;
      _correct++;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _target = _newTarget();
        _round++;
        _justSolved = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'صح: $_correct / $_needed',
                style: const TextStyle(
                  color: AppColors.whiteFaint,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Text(
                'مثّل هالرقم على العداد',
                style: TextStyle(color: AppColors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                '$_target',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedOpacity(
                opacity: _justSolved ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Text(
                  'صح! 🎉',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 110,
                child: Abacus(
                  key: ValueKey(_round),
                  columns: 1,
                  onValueChanged: _onValue,
                ),
              ),
              const Spacer(),
              if (_correct >= _needed)
                ElevatedButton(
                  onPressed: () => context.goNamed('mathSession'),
                  child: const Text('تخطي'),
                )
              else
                const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
